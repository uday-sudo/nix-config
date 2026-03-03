{
  inputs,
  lib,
  pkgs,
  ...
}: let
  defaultWallpaper = "${inputs.wallpapers}/regular/047.jpg";
in {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto, 1"
    ];
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
    master = {
      new_status = "master";
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [defaultWallpaper];
      wallpaper = [",${defaultWallpaper}"];
    };
  };

  services.hyprpolkitagent.enable = true;

  home.packages = [
    pkgs.grim
    pkgs.satty
    pkgs.slurp
    pkgs.hyprpicker
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.libnotify
  ];
}
