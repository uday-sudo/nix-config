{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.gaming;

  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
  };
in {
  options.programs.gaming = {
    enable = mkEnableOption "Enable gaming-related packages (Steam, Wine, etc.)";

    user = mkOption {
      type = types.str;
      default = "uday";
      description = "The user to whom gaming packages should be added.";
    };

    enableWine = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Wine for running Windows applications.";
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.user}.packages = with pkgs;
      [
        steam-with-pkgs
        gamescope
        protontricks
        lutris
        prismlauncher
      ]
      ++ (
        if cfg.enableWine
        then [
          # Wine packages for both 32-bit and 64-bit applications
          wine64
          # Winetricks for managing Wine environments
          winetricks
          # Native Wayland support for Wine (unstable)
          wineWowPackages.waylandFull
        ]
        else []
      );
  };
}
