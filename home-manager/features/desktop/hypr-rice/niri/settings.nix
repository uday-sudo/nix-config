{...}: {
  imports = [
    ./input.nix
    ./layout.nix
    ./window-rules.nix
    ./binds.nix
  ];

  programs.niri.settings = {
    prefer-no-csd = true;
    spawn-at-startup = [];
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
  };
}
