{config, ...}: let
  c = config.theme.colors;
in {
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    # Keep DMS theme stable and sourced from Stylix/Base16 instead of wallpaper-driven recoloring.
    enableDynamicTheming = false;
  };

  # DMS selectable installed theme format:
  # ~/.config/DankMaterialShell/themes/<id>/theme.json
  xdg.configFile."DankMaterialShell/themes/stylix/theme.json".text = builtins.toJSON {
    id = "stylix";
    name = "Stylix";
    version = "1.0.0";
    author = "nix-config";
    description = "Generated from Stylix Base16 colors";
    dark = {
      primary = c.base0D;
      primaryText = c.base00;
      primaryContainer = c.base0C;
      secondary = c.base0E;
      surface = c.base01;
      surfaceText = c.base05;
      surfaceVariant = c.base02;
      surfaceVariantText = c.base05;
      surfaceTint = c.base0D;
      background = c.base00;
      backgroundText = c.base05;
      outline = c.base03;
      surfaceContainer = c.base01;
      surfaceContainerHigh = c.base02;
      surfaceContainerHighest = c.base03;
      error = c.base08;
      warning = c.base0A;
      info = c.base0C;
      matugen_type = "scheme-tonal-spot";
    };
    light = {
      primary = c.base0D;
      primaryText = c.base07;
      primaryContainer = c.base0C;
      secondary = c.base0E;
      surface = c.base06;
      surfaceText = c.base01;
      surfaceVariant = c.base07;
      surfaceVariantText = c.base03;
      surfaceTint = c.base0D;
      background = c.base07;
      backgroundText = c.base01;
      outline = c.base04;
      surfaceContainer = c.base06;
      surfaceContainerHigh = c.base07;
      surfaceContainerHighest = c.base05;
      error = c.base08;
      warning = c.base09;
      info = c.base0C;
      matugen_type = "scheme-tonal-spot";
    };
  };
}
