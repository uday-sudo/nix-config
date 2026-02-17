{
  lib,
  pkgs,
  config,
  ...
}: let
  theme = config.theme;
  stripHash = lib.removePrefix "#";
in {
  # ------- GRAPHICS THEME ---------
  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = false;
    base16Scheme = {
      scheme = theme.scheme;
      author = theme.author;
      base00 = stripHash theme.colors.base00;
      base01 = stripHash theme.colors.base01;
      base02 = stripHash theme.colors.base02;
      base03 = stripHash theme.colors.base03;
      base04 = stripHash theme.colors.base04;
      base05 = stripHash theme.colors.base05;
      base06 = stripHash theme.colors.base06;
      base07 = stripHash theme.colors.base07;
      base08 = stripHash theme.colors.base08;
      base09 = stripHash theme.colors.base09;
      base0A = stripHash theme.colors.base0A;
      base0B = stripHash theme.colors.base0B;
      base0C = stripHash theme.colors.base0C;
      base0D = stripHash theme.colors.base0D;
      base0E = stripHash theme.colors.base0E;
      base0F = stripHash theme.colors.base0F;
    };
    targets = {
      gtk.enable = true;
      # qt.enable = true;
      kde.enable = true;
      btop.enable = true;
      hyprland.enable = true;
      zellij.enable = true;
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  # -------- CURSOR THEME -----------
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    hyprcursor = {
      enable = true;
      size = config.home.pointerCursor.size;
    };
  };
  # -------- ICON THEME -----------
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
