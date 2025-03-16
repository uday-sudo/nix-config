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
    # ./hangout.nix
    ./forgejo.nix
    ./containers.nix
  ];
}
