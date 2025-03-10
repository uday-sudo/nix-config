{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.theme.kitty;
  theme = config.theme.colors;
in {
  options.theme.kitty = {
    enable = mkEnableOption "Enable Kitty terminal theme configuration";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      settings = {
        # Basic colors
        foreground = "${theme.base05}";
        background = "${theme.base00}";
        selection_foreground = "${theme.base05}";
        selection_background = "${theme.base02}";

        # Cursor colors
        cursor = "${theme.base05}";
        cursor_text_color = "${theme.base00}";

        # Border colors
        active_border_color = "${theme.base0D}";
        inactive_border_color = "${theme.base02}";

        # Tab colors
        active_tab_foreground = "${theme.base00}";
        active_tab_background = "${theme.base05}";
        inactive_tab_foreground = "${theme.base02}";
        inactive_tab_background = "${theme.base04}";

        # 16-color palette
        color0 = "${theme.base00}";
        color8 = "${theme.base03}";

        color1 = "${theme.base08}";
        color9 = "${theme.base08}";

        color2 = "${theme.base0B}";
        color10 = "${theme.base0B}";

        color3 = "${theme.base0A}";
        color11 = "${theme.base0A}";

        color4 = "${theme.base0D}";
        color12 = "${theme.base0D}";

        color5 = "${theme.base0E}";
        color13 = "${theme.base0E}";

        color6 = "${theme.base0C}";
        color14 = "${theme.base0C}";

        color7 = "${theme.base05}";
        color15 = "${theme.base05}";
      };
    };
  };
}
