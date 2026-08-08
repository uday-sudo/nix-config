{
  inputs,
  pkgs,
  ...
}: let
  launcherCornerRadius = 12.0;
  windowRules = import ./window-rules.nix {inherit inputs;};
  defaultWallpaper = "${inputs.wallpapers}/regular/047.jpg";
  applyWallpaper = pkgs.writeShellApplication {
    name = "niri-apply-wallpaper";
    runtimeInputs = with pkgs; [
      awww
      coreutils
      dms-shell
      gnused
    ];
    text = ''
      set -eu

      wallpaper="$(${pkgs.dms-shell}/bin/dms ipc call wallpaper get 2>/dev/null || true)"
      [ -n "$wallpaper" ] || wallpaper='${defaultWallpaper}'

      outputs="$(${pkgs.awww}/bin/awww query 2>/dev/null | sed -E 's/^: ([^:]+):.*/\1/')"
      [ -n "$outputs" ] || exit 0

      printf '%s\n' "$outputs" \
        | while IFS= read -r output; do
            [ -n "$output" ] || continue
            ${pkgs.awww}/bin/awww img -o "$output" "$wallpaper" --resize crop
          done
    '';
  };

  watchWallpaper = pkgs.writeShellApplication {
    name = "niri-watch-wallpaper";
    runtimeInputs = with pkgs; [
      gnugrep
      niri
    ];
    text = ''
      set -eu

      ${applyWallpaper}/bin/niri-apply-wallpaper || true

      ${pkgs.niri}/bin/niri msg -j event-stream \
        | while IFS= read -r line; do
            case "$line" in
              *'"OutputsChanged"'*|*'"ConfigLoaded"'*)
                ${applyWallpaper}/bin/niri-apply-wallpaper || true
                ;;
            esac
          done
    '';
  };
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
            ${applyWallpaper}/bin/niri-apply-wallpaper
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

  systemd.user.services.niri-wallpaper-watch = {
    Unit = {
      Description = "Reapply wallpaper on Niri output changes";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
    };

    Service = {
      ExecStart = "${watchWallpaper}/bin/niri-watch-wallpaper";
      Restart = "always";
      RestartSec = 1;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
