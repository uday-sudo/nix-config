{
  inputs,
  config,
  ...
}:
{
  imports = [
    ./keybinds.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
