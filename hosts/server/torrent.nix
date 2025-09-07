{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.caddy = {
    virtualHosts."torrent.homebox.com" = {
      extraConfig = ''
        reverse_proxy http://localhost:7044
        request_body {
            max_size 100MB
        }
        tls internal
      '';
    };
  };
  services.qbittorrent = {
    package = pkgs.qbittorrent-nox;
    enable = true;
    group = "users";
    webuiPort = 7044;
  };  
  systemd.services.qbittorrent.wantedBy = lib.mkForce [];
}
