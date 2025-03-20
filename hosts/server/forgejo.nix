{ lib, pkgs, config, inputs, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.nginx = {
    virtualHosts.${cfg.settings.server.DOMAIN} = {
      forceSSL = true;
      enableACME = true;
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/".proxyPass = "http://localhost:${toString srv.HTTP_PORT}";
    };
  };

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    # lfs.enable = true;
    settings = {
      session.COOKIE_SECURE = true;
      DEFAULT = {
        APP_NAME = "Uday's Software forge";
        APP_SLOGAN = "To Code and beyond";
      };
      server = {
        DOMAIN = "git.homebox.com";
        ROOT_URL = "https://${srv.DOMAIN}/"; 
        HTTP_PORT = 3000;
      };
      service.DISABLE_REGISTRATION = false; 
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
        ARTIFACT_RETENTION_DAYS = 120;
      };
    };
    dump = {
      enable = true;
      backupDir = "/run/media/hdd/forgejo";
      interval = "22:00";
      type = "tar.zst";
    };
  };


  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "monolith";
      url = "https://git.example.com";
      # Obtaining the path to the runner token file may differ
      # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
      tokenFile = "/var/lib/forgejo/token";
      labels = [
        "ubuntu-latest:docker://node:16-bullseye"
        "ubuntu-22.04:docker://node:16-bullseye"
        "ubuntu-20.04:docker://node:16-bullseye"
        "ubuntu-18.04:docker://node:16-buster"     
        ## optionally provide native execution on the host:
        # "native:host"environment
      ];
    };
  };
  sops.secrets.forgejo-admin-password.owner = "forgejo";
  systemd.services.forgejo.preStart = let 
    adminCmd = "${lib.getExe cfg.package} admin user";
    pwd = config.sops.secrets.forgejo-admin-password;
    user = "admin";
  in ''
    #${adminCmd} create --admin --email "root@localhost" --username ${user} --password "$(tr -d '\n' < ${pwd.path})" || true
    ${adminCmd} create --email "root@localhost" --username hooman --password "12345678" || true
    ## uncomment this line to change an admin user which was already created
    # ${adminCmd} change-password --username ${user} --password "$(tr -d '\n' < ${pwd.path})" || true
  '';
}