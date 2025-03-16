{ lib, pkgs, config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
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
    lfs.enable = true;
    settings = {
      session.COOKIE_SECURE = true;
      DEFAULT.APP_NAME = "Uday's Software forge";
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
      };
    };
    dump = {
      enable = true;
      backupDir = "/run/media/hdd/forgejo";
      interval = "06:00";
      type = "tar.zst";
    };
  };
}