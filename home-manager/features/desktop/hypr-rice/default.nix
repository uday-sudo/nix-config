{
  imports = [
    ./keybinds.nix
    ./rofi.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
