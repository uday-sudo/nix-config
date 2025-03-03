
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
  ];

  home.packages = with pkgs; [
    brave
    keepassxc
  ];
}