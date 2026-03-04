{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  defaultWallpaper = "${inputs.wallpapers}/regular/047.jpg";
  theme = config.theme.colors;
  toHex = color:
    if lib.hasPrefix "#" color
    then color
    else "#${color}";
  hyprpolkitQml = pkgs.replaceVars ./hyprpolkit-main.qml {
    BASE04 = toHex theme.base04;
    BASE05 = toHex theme.base05;
    BASE08 = toHex theme.base08;
  };
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

  services.hyprpolkitagent = {
    enable = true;
    package = pkgs.hyprpolkitagent.overrideAttrs (old: {
      postPatch =
        (old.postPatch or "")
        + ''
          cp ${hyprpolkitQml} qml/main.qml
        '';
    });
  };

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
