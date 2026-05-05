{inputs, ...}: let
  launcherCornerRadius = 12.0;
  windowRules = import ./window-rules.nix {inherit inputs;};
in {
  imports = [
    ./input.nix
    ./layout.nix
    ./animations.nix
    ./binds.nix
  ];

  programs.niri.settings = {
    prefer-no-csd = true;
    spawn-at-startup = [];
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    gestures.hot-corners.enable = true;
    window-rules = windowRules.typed;

    layer-rules = [
      {
        matches = [
          {namespace = "^(launcher|rofi)$";}
        ];
        geometry-corner-radius = {
          top-left = launcherCornerRadius;
          top-right = launcherCornerRadius;
          bottom-left = launcherCornerRadius;
          bottom-right = launcherCornerRadius;
        };
        shadow.enable = true;
      }
    ];
  };

  services.cliphist.enable = true;
}
