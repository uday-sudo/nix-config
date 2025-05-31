{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  services.caddy = {
    virtualHosts."game.homebox.com" = {
      extraConfig = ''
        reverse_proxy http://localhost:7566
        tls internal
      '';
    };
  };

  systemd.services.pufferpanel.wantedBy = lib.mkForce [];

  services.pufferpanel = {
    enable = true;
    extraGroups = [
      "podman"
    ];
    extraPackages = [
      pkgs.openjdk
    ];
    environment = {
      PUFFER_WEB_HOST = ":7566";
      PUFFER_DAEMON_SFTP_HOST = ":5657";
      PUFFER_DAEMON_CONSOLE_BUFFER = "1000";
      PUFFER_DAEMON_CONSOLE_FORWARD = "true";
      PUFFER_PANEL_REGISTRATIONENABLED = "false";
    };
  };
  # systemd.services.pufferpanel.preStart = let
  #   adminCmd = "${lib.getExe config.services.pufferpanel.package}";
  # in ''
  #   echo "${adminCmd} user add --workDir /var/lib/pufferpanel"
  # '';
}
