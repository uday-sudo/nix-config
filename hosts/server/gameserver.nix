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
  # PufferPanel's systemd StateDirectory under /var/lib/pufferpanel is mounted
  # noexec, which breaks game server binaries like Terraria. Keep executable
  # server data under /srv so PufferPanel can launch downloaded binaries.
  dataDir = "/srv/pufferpanel";
in {
  users.users.pufferpanel = {
    isSystemUser = true;
    group = "pufferpanel";
  };

  users.groups.pufferpanel = {};

  systemd.tmpfiles.rules = [
    "d ${dataDir} 0750 pufferpanel pufferpanel - -"
    "d ${dataDir}/servers 0750 pufferpanel pufferpanel - -"
    "d ${dataDir}/binaries 0750 pufferpanel pufferpanel - -"
  ];

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
      pkgs.bash
      pkgs.curl
      pkgs.gawk
      pkgs.gnutar
      pkgs.gzip
      pkgs.openjdk
      pkgs.unzip
    ];
    package = pkgs.buildFHSEnv {
      name = "pufferpanel-fhs";
      runScript = lib.getExe pkgs.pufferpanel;
      targetPkgs = pkgs':
        with pkgs'; [
          bash
          coreutils
          curl
          gawk
          gnutar
          gzip
          icu
          openssl
          unzip
          zlib
        ];
    };
    environment = {
      PUFFER_WEB_HOST = ":${toString webPort}";
      PUFFER_DAEMON_SFTP_HOST = ":${toString sftpPort}";
      PUFFER_DAEMON_CONSOLE_BUFFER = "1000";
      PUFFER_DAEMON_CONSOLE_FORWARD = "true";
      PUFFER_PANEL_REGISTRATIONENABLED = "false";
      # systemd mounts StateDirectory under /var/lib/pufferpanel with noexec.
      # Keep executable server data outside that tree so game binaries can run.
      PUFFER_DAEMON_DATA_SERVERS = "${dataDir}/servers";
      PUFFER_DAEMON_DATA_BINARIES = "${dataDir}/binaries";
    };
  };

  systemd.services.pufferpanel.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = lib.mkForce "pufferpanel";
    Group = lib.mkForce "pufferpanel";
  };
  # systemd.services.pufferpanel.preStart = let
  #   adminCmd = "${lib.getExe config.services.pufferpanel.package}";
  # in ''
  #   echo "${adminCmd} user add --workDir /var/lib/pufferpanel"
  # '';
}
