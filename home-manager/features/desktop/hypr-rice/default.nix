{inputs, ...}: {
  imports = [
    inputs.stylix.homeModules.stylix
    ./keybinds.nix
    ./rofi.nix
    ./theme.nix
    ./misc.nix
    ./animation.nix
    ./plugins.nix
    ./windowrules.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
