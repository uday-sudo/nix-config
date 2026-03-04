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
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      bind =
      [
        "$mod, P, exec, ${lib.getExe pkgs.grim} - | ${lib.getExe pkgs.satty} --filename -"
        "$mod SHIFT, S, exec, ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe pkgs.satty} --filename -"
        "$mod CTRL, P, exec, ${lib.getExe pkgs.grim} -g \"$(hyprctl activewindow -j | ${lib.getExe pkgs.jq} -r '.at as $a | .size as $s | \"\\($a[0]),\\($a[1]) \\($s[0])x\\($s[1])\"')\" - | ${lib.getExe pkgs.satty} --filename -"
        "$mod, D, exec, rofi -show drun"
        "$mod, RETURN, exec, ${lib.getExe pkgs.ghostty};"
        "$mod, W, killactive"
        "$mod SHIFT, D, exec, ${toggleHyprbars}"
        "$mod, T, togglefloating"
        "$mod, F, fullscreen"
        "$mod Shift, F, fullscreenstate"
        "$mod Shift, Q, exit"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod CTRL, right, workspace, r+1"
        "$mod CTRL, left, workspace, r-1"
        "$mod CTRL, down, workspace, empty"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod ALT, S, movetoworkspacesilent, special"
        "$mod, S, togglespecialworkspace"
        "$mod CTRL ALT, right, movetoworkspace, r+1"
        "$mod CTRL ALT, left, movetoworkspace, r-1"
        "$mod SHIFT CTRL, left, movewindoworgroup, l"
        "$mod SHIFT CTRL, right, movewindoworgroup, r"
        "$mod SHIFT CTRL, up, movewindoworgroup, u"
        "$mod SHIFT CTRL, down, movewindoworgroup, d"
        "$mod SHIFT, R, submap, resize"
        "$mod, Z, submap, dwindle"
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

    extraConfig = ''
      submap=resize
      binde=,right,resizeactive,20 0
      binde=,left,resizeactive,-20 0
      binde=,up,resizeactive,0 -20
      binde=,down,resizeactive,0 20
      binde=,L,resizeactive,20 0
      binde=,H,resizeactive,-20 0
      binde=,K,resizeactive,0 -20
      binde=,J,resizeactive,0 20
      bind=,escape,submap,reset
      submap=reset

      submap=dwindle
      binde=,L,layoutmsg,preselect r
      binde=,H,layoutmsg,preselect l
      binde=,K,layoutmsg,preselect u
      binde=,J,layoutmsg,preselect d
      bind=,escape,submap,reset
      submap=reset
    '';
  };
}
