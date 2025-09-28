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
          icon = "<iconify-icon icon=\"streamline-color:button-power-1-flat\"></iconify-icon>";
        }
        {
          title = "Check disk space";
          shell = "df -h /run/media/hdd && df -h";
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "Manage Tailscale Connection";
          shell = "tailscale {{ command }}";
          icon = "<iconify-icon icon=\"simple-icons:tailscale\"></iconify-icon>";
          arguments = [
            {
              name = "command";
              title = "Tailscale Command";
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
          icon = "<iconify-icon icon=\"icon-park-solid:more-app\"></iconify-icon>";
          popupOnStart = "execution-dialog-stdout-only";
        }
        {
          title = "Manage Services";
          icon = "<iconify-icon icon=\"uil:setting\"></iconify-icon>";
          shell = "systemctl {{ action }} {{ service }}";
          timeout = 10;
          arguments = [
            {
              name = "service";
              title = "Select Service";
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
          icon = "<iconify-icon icon=\"streamline-color:button-power-1-flat\"></iconify-icon>";
          shell = "shutdown -h \+{{ delay }}";
          arguments = [
            {
              name = "delay";
              title = "Delay (in minutes)";
              type = "int";
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
        {
          title = "Cancel Scheduled Shutdown";
          icon = "<iconify-icon icon=\"streamline-stickies-color:cancel-2\"></iconify-icon>";
          shell = "shutdown -c";
          popupOnStart = "execution-dialog-stdout-only";
        }
      ];
    };
  };
}
