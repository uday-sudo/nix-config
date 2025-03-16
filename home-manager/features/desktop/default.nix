{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./mpv.nix
    ./firefox
    ./cursor.nix
    ./plasma.nix
    ./syncthing.nix
  ];

  home.packages = with pkgs; [
    brave
    keepassxc
  ];
}
