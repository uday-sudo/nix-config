{inputs, ...}: {
  imports = [
    inputs.stylix.homeModules.stylix
    ./hyprland
    ./niri
    ./rofi.nix
    ./theme.nix
  ];
  wayland.windowManager.hyprland.enable = true;

  programs.ignis = {
    enable = true;
    addToPythonEnv = true;
    services = {
      bluetooth.enable = true;
      recorder.enable = true;
      audio.enable = true;
      network.enable = true;
    };
    sass = {
      enable = true;
      useDartSass = true;
    };
  };
}
