{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  # GRUB THEME
  boot.loader.grub2-theme = {
    enable = true;
    theme = "vimix";
    footer = true;
    customResolution = "1920x1080"; # Optional: Set a custom resolution
  };
}
