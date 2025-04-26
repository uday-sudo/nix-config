{
  config,
  pkgs,
  ...
}: {
  theme.kitty.enable = true;
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
  };
}
