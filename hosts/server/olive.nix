{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    olivetin
  ];

  services.caddy = {
    enable = true;
    virtualHosts."olive.homebox.com".extraConfig = ''
      reverse_proxy * http://localhost:1337
      tls internal
    '';
  };

  services.olivetin = {
    enable = true;
    user = "root";
    path = with pkgs; [
      bash
      iputils
      systemd
      tailscale
    ];
    settings = {
      ListenAddressSingleHTTPFrontend = "0.0.0.0:1337";
      actions = [
        {
          title = "Ping the Internet";
          shell = "ping -c 3 1.1.1.1";
          icon = "ping";
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "System Power Options";
          shell = "systemctl {{ action }}";
          arguments = [
            {
              name = "action";
              title = "Choose Action";
              type = "choice";
              choices = [
                {
                  title = "Reboot";
                  value = "reboot";
                }
                {
                  title = "Shutdown";
                  value = "poweroff";
                }
              ];
            }
          ];
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "Check disk space";
          shell = "df -h /run/media/hdd && df -h";
          icon = "disk";
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "Manage Tailscale Connection";
          shell = "tailscale {{ command }}";
          arguments = [
            {
              name = "command";
              title = "Tailscale Command";
              type = "choice";
              choices = [
                {
                  title = "Up";
                  value = "up";
                }
                {
                  title = "Down";
                  value = "down";
                }
              ];
            }
          ];
        }
        {
          title = "Check Service Statuses";
          shell = "systemctl status filebowser qbittorrent jellyfin pufferpanel forgejo";
          icon = "info";
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "Manage Services";
          icon = "settings";
          shell = "systemctl {{ action }} {{ service }}";
          timeout = 10;
          arguments = [
            {
              name = "service";
              title = "Select Service";
              type = "choice";
              choices = [
                {
                  title = "FileBowser";
                  value = "filebowser";
                }
                {
                  title = "qBittorrent";
                  value = "qbittorrent";
                }
                {
                  title = "Jellyfin";
                  value = "jellyfin";
                }
                {
                  title = "PufferPanel";
                  value = "pufferpanel";
                }
                {
                  title = "Forgejo";
                  value = "forgejo";
                }
              ];
            }
            {
              name = "action";
              title = "Select Action";
              type = "choice";
              choices = [
                {
                  title = "Start";
                  value = "start";
                }
                {
                  title = "Stop";
                  value = "stop";
                }
                {
                  title = "Restart";
                  value = "restart";
                }
              ];
            }
          ];
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "Schedule Shutdown";
          icon = "clock";
          shell = "shutdown +{{ delay }}";
          arguments = [
            {
              name = "delay";
              title = "Delay (in minutes)";
              type = "text";
              default = "10";
            }
          ];
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "Check Scheduled Shutdown";
          icon = "info";
          shell = "shutdown --show";
          popupOnStart = "execution-dialog-stdout-only";
        }
      ];
    };
  };
}
