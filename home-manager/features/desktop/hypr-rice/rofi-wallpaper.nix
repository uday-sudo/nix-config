{
  inputs,
  pkgs,
  theme,
}: let
  wallpaperPickerMode = pkgs.writeShellApplication {
    name = "rofi-wallpaper-picker-mode";
    runtimeInputs = with pkgs; [
      awww
      coreutils
      findutils
      gnused
      coreutils
    ];
    text = ''
      set -eu

      wallpaper_root='${inputs.wallpapers}'

      if [ -n "''${ROFI_INFO:-}" ]; then
        transition="$(
          printf '%s\n' center any random wipe wave grow outer \
            | shuf -n 1
        )"
        exec ${pkgs.awww}/bin/awww img "$ROFI_INFO" --resize crop --transition-type "$transition" --transition-step 90 --transition-fps 60 --transition-duration 2
      fi

      find "$wallpaper_root" -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' -o -iname '*.gif' \) \
        | sort \
        | while IFS= read -r file; do
            [ -n "$file" ] || continue
            name="''${file#"$wallpaper_root"/}"
            printf '%s\0icon\x1f%s\x1finfo\x1f%s\n' "$name" "$file" "$file"
          done
    '';
  };

  wallpaperPicker = pkgs.writeShellApplication {
    name = "rofi-wallpaper-picker";
    runtimeInputs = with pkgs; [
      rofi
    ];
    text = ''
      exec rofi \
        -theme "$HOME/.config/rofi/wallpaper-theme.rasi" \
        -show wallpaper \
        -modi "wallpaper:${wallpaperPickerMode}/bin/rofi-wallpaper-picker-mode"
    '';
  };

  wallpaperTheme = pkgs.writeText "rofi-wallpaper-theme.rasi" ''
    configuration {
      show-icons: true;
    }

    * {
      font: "Inter Variable 11";
      background: ${theme.base00};
      background-alt: ${theme.base01};
      surface: ${theme.base01};
      surface-alt: ${theme.base02};
      foreground: ${theme.base05};
      muted: ${theme.base04};
      selected: ${theme.base0D};
      border: ${theme.base03};
      transparent: #00000000;
    }

    window {
      transparency: "real";
      location: south;
      anchor: south;
      fullscreen: false;
      width: 100%;
      x-offset: 0px;
      y-offset: 0px;
      enabled: true;
      margin: 0px;
      padding: 0px;
      border: 0px;
      border-radius: 0px;
      border-color: @border;
      background-color: @background;
      cursor: "default";
    }

    mainbox {
      enabled: true;
      spacing: 16px;
      margin: 0px;
      padding: 14px 18px 10px 18px;
      border: 0px;
      background-color: transparent;
      children: [ "inputbar", "listview" ];
    }

    inputbar {
      enabled: true;
      spacing: 12px;
      margin: 0px;
      padding: 14px 18px;
      border: 0px;
      border-radius: 12px;
      background-color: @surface-alt;
      text-color: @foreground;
      children: [ "prompt", "entry" ];
    }

    prompt {
      enabled: true;
      expand: false;
      padding: 0px 6px 0px 0px;
      background-color: transparent;
      text-color: @selected;
      font: "Iosevka Nerd Font 12";
      str: "󰸉";
    }

    entry {
      enabled: true;
      background-color: transparent;
      text-color: inherit;
      cursor: text;
      placeholder: "Search wallpapers...";
      placeholder-color: @muted;
    }

    listview {
      enabled: true;
      columns: 8;
      lines: 2;
      cycle: true;
      dynamic: false;
      scrollbar: false;
      layout: vertical;
      reverse: false;
      fixed-height: false;
      fixed-columns: true;
      spacing: 12px;
      margin: 0px;
      padding: 0px;
      border: 0px;
      background-color: transparent;
      text-color: @foreground;
      cursor: "default";
    }

    element {
      enabled: true;
      orientation: vertical;
      spacing: 0px;
      margin: 0px;
      padding: 4px 4px 0px 4px;
      border: 0px;
      border-radius: 14px;
      background-color: @surface;
      text-color: @foreground;
      cursor: pointer;
    }

    element normal.normal {
      background-color: @surface;
      text-color: @foreground;
    }

    element selected.normal {
      background-color: @selected;
      text-color: @background;
    }

    element-icon {
      background-color: transparent;
      text-color: inherit;
      size: 184px;
      border-radius: 12px;
      horizontal-align: 0.5;
      vertical-align: 0.5;
      cursor: inherit;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      highlight: inherit;
      cursor: inherit;
      horizontal-align: 0.5;
      vertical-align: 0.5;
      width: 14ch;
      padding: 0px 4px;
      margin: 0px 0px 4px 0px;
    }

    textbox {
      background-color: transparent;
      text-color: @foreground;
      vertical-align: 0.5;
      horizontal-align: 0.0;
      highlight: none;
    }

    error-message {
      padding: 14px;
      border: 0px;
      border-radius: 12px;
      background-color: @surface-alt;
      text-color: @foreground;
    }
  '';
in {
  inherit wallpaperPickerMode wallpaperPicker wallpaperTheme;
}
