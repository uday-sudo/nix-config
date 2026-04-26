{inputs, ...}: {
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.dms.homeModules.dank-material-shell
    ./hyprland
    ./niri
    ./dms.nix
    ./rofi.nix
    ./theme.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
