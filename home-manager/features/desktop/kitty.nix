{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrainsMono NFM";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 14;
      adjust_line_height = 1;
      adjust_column_width = 0;
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 2;
      tab_powerline_style = "round";
      active_tab_font_style = "bold-italic";
      inactive_tab_font_style = "normal";
      background_opacity = 1;
    };

    # Catpuccin Mocha theme
    settings = {
      foreground = "#bbc2cf";
      background = "#282c34";
      selection_foreground = "#bbc2cf";
      selection_background = "#3f444a";

      cursor = "#bbc2cf";
      cursor_text_color = "#282c34";

      active_border_color = "#46D9FF";
      inactive_border_color = "#3f444a";

      active_tab_foreground = "#282c34";
      active_tab_background = "#DFDFDF";
      inactive_tab_foreground = "#3f444a";
      inactive_tab_background = "#5B6268";

      # The basic 16 colors
      color0 = "#2a2e38";
      color8 = "#3f444a";

      color1 = "#ff6c6b";
      color9 = "#ff6655";

      color2 = "#98be65";
      color10 = "#99bb66";

      color3 = "#ECBE7B";
      color11 = "#ECBE7B";

      color4 = "#51afef";
      color12 = "#51afef";

      color5 = "#c678dd";
      color13 = "#c678dd";

      color6 = "#46D9FF";
      color14 = "#46D9FF";

      color7 = "#DFDFDF";
      color15 = "#bbc2cf";
    };
  };
}