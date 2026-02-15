{inputs, ...}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ./keybinds.nix
    ./rofi.nix
    ./theme.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
