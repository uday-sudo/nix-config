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
    description = "OliveTin web interface for running commands";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "simple";
      User = "olivetin";
      Group = "olivetin";
      ExecStart = "${pkgs.olivetin}/bin/OliveTin --configdir /etc/olivetin --port 1337";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  environment.etc."olivetin/config.yaml".text = ''
    # Basic OliveTin configuration
    actions:
      - title: "Echo Hello"
        shell: echo "Hello World"
  '';
}
