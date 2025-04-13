{ inputs, lib, config, ...}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.nginx = {
    virtualHosts."torrent.homebox.com" = {
      forceSSL = true;
      sslCertificate = config.sops.secrets."nginx/SSL-cert".path;
      sslCertificateKey = config.sops.secrets."nginx/SSL-key".path;
      locations."/" = {
        proxyPass = "http://127.0.0.1:7044";
         proxyWebsockets = true;
         extraConfig = ''
          #  proxy_http_version 1.1;
           proxy_set_header Host               $proxy_host;
           proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Host   $http_host;
           proxy_set_header X-Forwarded-Proto  $scheme;
           client_max_body_size 100M;
         '';
      };
    };
  };
  services.qbittorrent = {
    enable = true;
    group = "users";
    port = 7044;
  };
  systemd.services.qbittorrent.wantedBy = lib.mkForce [];

}