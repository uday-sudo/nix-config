{
  lib,
  pkgs,
  ...
}: let
  toggleHyprbars = pkgs.writeShellScript "hyprbars-toggle" ''
    set -euo pipefail
    state="$(hyprctl getoption -j plugin:hyprbars:enabled | ${lib.getExe pkgs.jq} -r '.int')"
    if [ "$state" -eq 1 ]; then
      hyprctl keyword plugin:hyprbars:enabled 0
    else
      hyprctl keyword plugin:hyprbars:enabled 1
    fi
  '';
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, P, exec, ${lib.getExe pkgs.grim} - | ${lib.getExe pkgs.satty} --filename -"
        "$mod, D, exec, rofi -show drun"
        "$mod, RETURN, exec, ${lib.getExe pkgs.ghostty};"
        "$mod SHIFT, S, exec, ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe pkgs.satty} --filename -"
        "$mod CTRL, P, exec, ${lib.getExe pkgs.grim} -g \"$(hyprctl activewindow -j | ${lib.getExe pkgs.jq} -r '.at as $a | .size as $s | \"\\($a[0]),\\($a[1]) \\($s[0])x\\($s[1])\"')\" - | ${lib.getExe pkgs.satty} --filename -"
        "$mod, W, killactive"
        "$mod SHIFT, D, exec, ${toggleHyprbars}"
        "$mod, T, togglefloating"
        "$mod, F, fullscreen"
        "$mod Shift, F, fullscreenstate"
        "$mod Shift, Q, exit"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9
        )
      );

    input = {
      scroll_method = "edge";
    };
    gesture = "3, horizontal, workspace";
  };
}
