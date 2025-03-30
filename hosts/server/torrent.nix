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
        proxyPass = "http://localhost:${toString config.services.qbittorrent.port}";
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