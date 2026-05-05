{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = config.theme.colors;
  clipboardTheme = pkgs.writeText "rofi-clipboard-theme.rasi" ''
    configuration {
      show-icons: true;
      drun-display-format: "{name}";
      window-format: "{w} · {c} · {t}";
    }

    * {
      font: "Inter Variable 12";
      background: ${theme.base00};
      background-alt: ${theme.base01};
      foreground: ${theme.base05};
      selected: ${theme.base0D};
      active: ${theme.base0B};
      urgent: ${theme.base08};
      border-colour: @selected;
      handle-colour: @foreground;
      background-colour: @background;
      foreground-colour: @foreground;
      alternate-background: @background-alt;
      normal-background: @background;
      normal-foreground: @foreground;
      urgent-background: @urgent;
      urgent-foreground: @background;
      active-background: @active;
      active-foreground: @background;
      selected-normal-background: @selected;
      selected-normal-foreground: @background;
      selected-urgent-background: @active;
      selected-urgent-foreground: @background;
      selected-active-background: @urgent;
      selected-active-foreground: @background;
      alternate-normal-background: @background;
      alternate-normal-foreground: @foreground;
      alternate-urgent-background: @urgent;
      alternate-urgent-foreground: @background;
      alternate-active-background: @active;
      alternate-active-foreground: @background;
    }

    window {
      transparency: "real";
      location: center;
      anchor: center;
      fullscreen: false;
      width: 760px;
      x-offset: 0px;
      y-offset: 0px;
      enabled: true;
      margin: 0px;
      padding: 0px;
      border: 3px;
      border-radius: 8px;
      border-color: @border-colour;
      cursor: "default";
      background-color: @background-colour;
    }

    mainbox {
      enabled: true;
      spacing: 10px;
      margin: 0px;
      padding: 40px;
      border: 0px solid;
      border-radius: 0px;
      border-color: @border-colour;
      background-color: transparent;
      children: [ "inputbar", "message", "listview", "mode-switcher" ];
    }

    inputbar {
      enabled: true;
      spacing: 10px;
      margin: 0px;
      padding: 0px;
      border: 0px solid;
      border-radius: 0px;
      border-color: @border-colour;
      background-color: transparent;
      text-color: @foreground-colour;
      children: [ "prompt", "entry" ];
    }

    prompt {
      enabled: true;
      font: "Iosevka Nerd Font 12";
      background-color: inherit;
      text-color: inherit;
    }

    textbox-prompt-colon {
      enabled: true;
      expand: false;
      str: "::";
      background-color: inherit;
      text-color: inherit;
    }

    entry {
      enabled: true;
      background-color: inherit;
      text-color: inherit;
      cursor: text;
      placeholder: "search...";
      placeholder-color: inherit;
    }

    listview {
      enabled: true;
      columns: 1;
      lines: 12;
      cycle: true;
      dynamic: true;
      scrollbar: true;
      layout: vertical;
      reverse: false;
      fixed-height: true;
      fixed-columns: true;
      margin: 0px;
      padding: 0px;
      border: 0px solid;
      border-radius: 0px;
      border-color: @border-colour;
      spacing: 6px;
      background-color: transparent;
      text-color: @foreground-colour;
      cursor: "default";
    }

    scrollbar {
      handle-width: 5px;
      handle-color: @handle-colour;
      border-radius: 8px;
      background-color: @alternate-background;
    }

    element {
      enabled: true;
      spacing: 8px;
      margin: 0px;
      padding: 8px;
      border: 0px solid;
      border-radius: 4px;
      border-color: @border-colour;
      background-color: transparent;
      text-color: @foreground-colour;
      cursor: pointer;
    }

    element normal.normal {
      background-color: @normal-background;
      text-color: @foreground;
    }

    element selected.normal {
      background-color: @selected-normal-background;
      text-color: @selected-normal-foreground;
    }

    element-icon {
      text-color: inherit;
      background-color: transparent;
      size: 24px;
      cursor: inherit;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      highlight: inherit;
      cursor: inherit;
      horizontal-align: 0.0;
      vertical-align: 0.5;
    }

    mode-switcher {
      enabled: true;
      spacing: 10px;
      margin: 0px;
      padding: 0px;
      border: 0px solid;
      border-radius: 0px;
      border-color: @border-colour;
      background-color: transparent;
      text-color: @foreground-colour;
    }

    button {
      padding: 8px;
      border: 0px solid;
      border-radius: 4px;
      border-color: @border-colour;
      background-color: @alternate-background;
      text-color: inherit;
      cursor: pointer;
    }

    button selected {
      background-color: @selected-normal-background;
      text-color: @selected-normal-foreground;
    }

    message {
      enabled: true;
      margin: 0px;
      padding: 0px;
      border: 0px solid;
      border-radius: 0px;
      border-color: @border-colour;
      background-color: transparent;
      text-color: @foreground-colour;
    }

    textbox {
      padding: 8px;
      border: 0px solid;
      border-radius: 4px;
      border-color: @border-colour;
      background-color: @alternate-background;
      text-color: @foreground-colour;
      vertical-align: 0.5;
      horizontal-align: 0.0;
      highlight: none;
      placeholder-color: @foreground-colour;
      blink: true;
      markup: true;
    }

    error-message {
      padding: 10px;
      border: 0px solid;
      border-radius: 4px;
      border-color: @border-colour;
      background-color: @background-colour;
      text-color: @foreground-colour;
    }
  '';
in {
  programs.rofi = {
    enable = true;
    terminal = "${lib.getExe pkgs.ghostty}";
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
    };
    theme = "${pkgs.writeText "rofi-theme.rasi" ''
      configuration {
        modi: "drun,run";
        show-icons: true;
        display-drun: " ";
        display-run: " ";
        drun-display-format: "{name}";
      }

      * {
        font: "Inter Variable 11";
        background: ${theme.base00};
        background-alt: ${theme.base01};
        foreground: ${theme.base05};
        selected: ${theme.base0D};
        active: ${theme.base0B};
        urgent: ${theme.base08};
        border: ${theme.base03};
      }

      window {
        transparency: "real";
        location: center;
        anchor: center;
        fullscreen: false;
        width: 400px;
        x-offset: 0px;
        y-offset: 0px;

        enabled: true;
        margin: 0px;
        padding: 0px;
        border: 3px;
        border-radius: 12px;
        border-color: @border;
        background-color: @background;
        cursor: "default";
      }

      mainbox {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 0px;
        border: 0px solid;
        border-radius: 0px;
        border-color: @selected;
        background-color: transparent;
        children: [ "inputbar", "listview" ];
      }

      inputbar {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 15px;
        border: 0px solid;
        border-radius: 0px;
        border-color: @selected;
        background-color: @selected;
        text-color: @background;
        children: [ "prompt", "entry" ];
      }

      prompt {
        enabled: true;
        font: "Iosevka Nerd Font 11";
        background-color: inherit;
        text-color: inherit;
      }

      textbox-prompt-colon {
        enabled: true;
        expand: false;
        str: "::";
        background-color: inherit;
        text-color: inherit;
      }

      entry {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        cursor: text;
        placeholder: "Search...";
        placeholder-color: inherit;
      }

      listview {
        enabled: true;
        columns: 1;
        lines: 6;
        cycle: true;
        dynamic: true;
        scrollbar: false;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;

        spacing: 5px;
        margin: 0px;
        padding: 0px;
        border: 0px solid;
        border-radius: 0px;
        border-color: @selected;
        background-color: transparent;
        text-color: @foreground;
        cursor: "default";
      }

      scrollbar {
        handle-width: 5px;
        handle-color: @selected;
        border-radius: 0px;
        background-color: @background-alt;
      }

      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 8px;
        border: 0px solid;
        border-radius: 0px;
        border-color: @selected;
        background-color: transparent;
        text-color: @foreground;
        cursor: pointer;
      }

      element normal.normal {
        background-color: @background;
        text-color: @foreground;
      }

      element selected.normal {
        background-color: @background-alt;
        text-color: @foreground;
      }

      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 32px;
        cursor: inherit;
      }

      element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
      }

      error-message {
        padding: 15px;
        border: 2px solid;
        border-radius: 12px;
        border-color: @selected;
        background-color: @background;
        text-color: @foreground;
      }

      textbox {
        background-color: @background;
        text-color: @foreground;
        vertical-align: 0.5;
        horizontal-align: 0.0;
        highlight: none;
      }
    ''}";
  };

  xdg.configFile."rofi/clipboard-theme.rasi".source = clipboardTheme;
}
