{inputs, ...}: {
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.dms.homeModules.dank-material-shell
    ./niri
    ./dms.nix
    ./rofi.nix
    ./theme.nix
  ];
}
