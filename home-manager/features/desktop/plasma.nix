{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  theme = config.theme;
in {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  home.packages = with pkgs;
    [
      papirus-icon-theme
      bibata-cursors
    ]
    ++ (
      if theme.scheme == "Catppuccin"
      then [
        (pkgs.catppuccin-kde.override {
          flavour = [(lib.toLower theme.flavor)];
          accents = [(lib.toLower theme.accent)];
        })
      ]
      else []
    );

  programs.plasma = {
    enable = true;

    #
    # Some high-level settings:
    #
    workspace = {
      clickItemTo = "select";
      cursor.theme = "Bibata-Modern-Ice";
      iconTheme = "Papirus-Dark";
      wallpaper = "${inputs.wallpapers}/regular/012.png";
    };

    panels = [
      {
        location = "top";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
        floating = true;
      }
      # Global menu at the top
      # {
      #   location = "top";
      #   height = 26;
      #   widgets = [ "org.kde.plasma.appmenu" ];
      # }
    ];

    #
    # Some mid-level settings:
    #
    # shortcuts = {
    #   ksmserver = {
    #     "Lock Session" = [
    #       "Screensaver"
    #       "Meta+Ctrl+Alt+L"
    #     ];
    #   };

    #   kwin = {
    #     "Expose" = "Meta+,";
    #     "Switch Window Down" = "Meta+J";
    #     "Switch Window Left" = "Meta+H";
    #     "Switch Window Right" = "Meta+L";
    #     "Switch Window Up" = "Meta+K";
    #   };
    # };
    kwin.effects = {
      shakeCursor.enable = true;
      translucency.enable = true;
    };

    #
    # Some low-level settings:
    #
    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "SF";
      "kwinrc"."Desktops"."Number" = {
        value = 3;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
    };
  };
}
