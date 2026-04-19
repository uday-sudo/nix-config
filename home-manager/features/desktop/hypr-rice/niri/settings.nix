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

    layer-rules = [
      {
        matches = [
          {namespace = "^(launcher|rofi)$";}
        ];
        geometry-corner-radius = {
          top-left = 10.0;
          top-right = 10.0;
          bottom-left = 10.0;
          bottom-right = 10.0;
        };
        shadow.enable = true;
      }
    ];
  };
}
