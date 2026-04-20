{...}: let
  launcherCornerRadius = 12.0;
in {
  imports = [
    ./input.nix
    ./layout.nix
    ./animations.nix
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
