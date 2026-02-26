{inputs, ...}: {
  imports = [
    inputs.stylix.homeModules.stylix
    ./keybinds.nix
    ./rofi.nix
    ./theme.nix
    ./misc.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
