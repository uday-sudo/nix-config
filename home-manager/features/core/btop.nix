{ config, pkgs, lib, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      update_ms = lib.mkDefault 1000;
      proc_sorting = lib.mkDefault "memory";
      proc_reversed = lib.mkDefault false;

      # Color settings
      color_theme = lib.mkDefault "catppuccin_mocha";
      theme_background = lib.mkDefault false;
    };
  };
}
