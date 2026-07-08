{
  inputs,
  pkgs,
  ...
}: let
  launcherCornerRadius = 12.0;
  windowRules = import ./window-rules.nix {inherit inputs;};
  defaultWallpaper = "${inputs.wallpapers}/regular/047.jpg";
in {
  imports = [
    ./input.nix
    ./layout.nix
    ./animations.nix
    ./binds.nix
  ];

  programs.niri.settings = {
    prefer-no-csd = true;
    outputs = {
      "01-external" = {
        name = "HDMI-A-1";
        focus-at-startup = true;
        mode = {
          width = 1920;
          height = 1080;
          refresh = 119.997;
        };
        position = {
          x = 1920;
          y = 0;
        };
      };
      "02-laptop" = {
        name = "eDP-1";
        mode = {
          width = 1920;
          height = 1200;
        };
        position = {
          x = 0;
          y = 0;
        };
      };
    };
    spawn-at-startup = [
      {
        command = [
          "${pkgs.awww}/bin/awww-daemon"
        ];
      }
      {
        command = [
          "sh"
          "-lc"
          ''
            ${pkgs.awww}/bin/awww query \
              | while IFS= read -r output; do
                  output="''${output%%:*}"
                  [ -n "$output" ] || continue
                  ${pkgs.awww}/bin/awww img -o "$output" ${defaultWallpaper} --resize crop
                done
          ''
        ];
      }
    ];
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
