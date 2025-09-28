{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./syncthing.nix
    ./filebrowser.nix
    ./torrent.nix
    ./forgejo.nix
    ./containers.nix
    ./video.nix
    ./dns.nix
    ./olive.nix
    ./gameserver.nix
    ./immich.nix
    inputs.sops-nix.nixosModules.sops
  ];

  services.nginx.enable = false;
  services.caddy.enable = true;
}
