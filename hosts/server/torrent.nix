{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  domain = config.homebox.domain;
  svcName = "torrent";
  port = 7044;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.caddy = {
    virtualHosts."${svcName}.${domain}" = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString port}
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
    webuiPort = port;
  };
  systemd.services.qbittorrent.wantedBy = lib.mkForce [];
}
