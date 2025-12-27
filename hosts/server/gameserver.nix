{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  domain = config.homebox.domain;
  svcName = "game";
  webPort = 7566;
  sftpPort = 5657;
in {
  services.caddy = {
    virtualHosts."${svcName}.${domain}" = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString webPort}
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
      PUFFER_WEB_HOST = ":${toString webPort}";
      PUFFER_DAEMON_SFTP_HOST = ":${toString sftpPort}";
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
