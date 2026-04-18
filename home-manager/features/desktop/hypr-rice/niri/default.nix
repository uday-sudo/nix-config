{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    ./settings.nix
  ];

  programs.niri.enable = true;
}
