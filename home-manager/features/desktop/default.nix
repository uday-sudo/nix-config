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
  ];

  # home.packages = with pkgs; [
  # ];
}
