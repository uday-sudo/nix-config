
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
  ];

  home.packages = with pkgs; [
    brave
  ];
}
