{ inputs, config, lib, pkgs, ...}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    olivetin
  ];

  services.nginx = {
    virtualHosts."olive.homebox.com" = {
      forceSSL = true;
      sslCertificate = config.sops.secrets."nginx/SSL-cert".path;
      sslCertificateKey = config.sops.secrets."nginx/SSL-key".path;
      locations."/" = {
        proxyPass = "http://localhost:1337";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_redirect http://localhost:1337/ http://localhost/OliveTin/;
        '';
      };
      locations."/websocket" = {
        proxyPass = "http://localhost:1337/websocket";
        proxyWebsockets = true;
      };
    };
  };

  # Create the user and group
  users.users.olivetin = {
    isSystemUser = true;
    group = "olivetin";
    description = "OliveTin service user";
    home = "/var/lib/olivetin";
    createHome = true;
  };

  users.groups.olivetin = {};
  
  # Ensure directories exist
  systemd.tmpfiles.rules = [
    "d /etc/olivetin 0755 olivetin olivetin - -"
    "d /var/lib/olivetin 0755 olivetin olivetin - -"
  ];

  systemd.services.olivetin = {
    path = with pkgs; [ bash sudo ];
    description = "OliveTin web interface for running commands";
    after = [ "network.target" ];
    wantedBy = []; #[ "multi-user.target" ];
    
    serviceConfig = {
      Type = "simple";
      User = "olivetin";
      Group = "olivetin";
      ExecStart = "${pkgs.olivetin}/bin/OliveTin --configdir /etc/olivetin";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  security.sudo.extraRules = [
    {
      users = [ "olivetin" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # environment.etc."olivetin/config.yaml".text = ''
  #   # Basic OliveTin configuration

  #   listenAddressSingleHTTPFrontend: 0.0.0.0:1337
  #   checkForUpdates: false
  #   actions:
  #     - title: Ping the Internet
  #       shell: ping -c 3 1.1.1.1
  #       icon: ping
  #       popupOnStart: execution-dialog-stdout-only
      
  #     - title: "System Power Options"
  #       shell: "sudo systemctl {{ action }}"
  #       arguments:
  #         - name: action
  #           title: "Choose Action"
  #           type: choice
  #           choices:
  #             - title: "Reboot"
  #               value: "reboot"
  #             - title: "Shutdown"
  #               value: "poweroff"
      
  #     # This uses `popupOnStart: execution-dialog-stdout-only` to simply show just
  #     # the command output.
  #     - title: Check disk space
  #       icon: disk
  #       shell: df -h /media
  #       popupOnStart: execution-dialog-stdout-only

  #     - title: "Manage Tailscale Connection"
  #       shell: "sudo tailscale {{ command }}"
  #       arguments:
  #         - name: command
  #           title: "Tailscale Command"
  #           type: choice
  #           choices:
  #             - title: "Up"
  #               value: "up"
  #             - title: "Down"
  #               value: "down"
  # '';
}

