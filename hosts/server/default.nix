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
  ];
}
