{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = config.theme.colors;
  stripHash = lib.removePrefix "#";
in {
  wayland.windowManager.hyprland = {
    plugins = [
      # pkgs.hyprlandPlugins.hyprbars
    ];
    settings.plugin.hyprbars = {
      enabled = false;
      bar_blur = false;
      bar_color = "rgb(${stripHash theme.base01})";
      col.text = "rgb(${stripHash theme.base05})";
      inactive_button_color = "rgb(${stripHash theme.base02})";
      bar_height = 24;
      bar_button_padding = 8;
      hyprbars-button = [
        "rgb(${stripHash theme.base08}), 12, , hyprctl dispatch killactive, rgb(${stripHash theme.base00})"
        "rgb(${stripHash theme.base09}), 12, , hyprctl dispatch fullscreen 1, rgb(${stripHash theme.base00})"
      ];
    };
  };
}
