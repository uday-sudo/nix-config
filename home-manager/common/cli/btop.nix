{ config, pkgs, ... }:

{
  programs.btop = {
    enable = true;

    settings = {
      update_ms = 1000;
      proc_sorting = "memory";
      proc_reversed = false;

      # Color settings
      color_theme = "catppuccin_mocha";
      theme_background = false;
    };
  };
}