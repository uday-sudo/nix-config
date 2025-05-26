{
  inputs,
  lib,
  config,
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
    enable = true;
    group = "users";
    port = 7044;
  };
  systemd.services.qbittorrent.wantedBy = lib.mkForce [];
}
