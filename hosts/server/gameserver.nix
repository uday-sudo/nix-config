{ inputs, config, lib, pkgs, ...}:
{
  services.nginx = {
    virtualHosts."game.homebox.com" = {
      forceSSL = true;
      sslCertificate = config.sops.secrets."nginx/SSL-cert".path;
      sslCertificateKey = config.sops.secrets."nginx/SSL-key".path;
      locations."/" = {
        proxyPass = "http://localhost:7566";
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
          proxy_http_version 1.1;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host $host;
          proxy_set_header Connection "Upgrade";
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header X-Nginx-Proxy true;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };

  systemd.services.pufferpanel.wantedBy = lib.mkForce [];

  services.pufferpanel = {
    enable = true;
    extraGroups = [
      "podman"
    ];
    extraPackages = [
      pkgs.jre
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
