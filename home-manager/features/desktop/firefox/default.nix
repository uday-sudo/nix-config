{config, pkgs, inputs, ...}:
{
  imports = [
    ./theme.nix
  ];

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      #   "{7aa7c68a-141f-45c9-a1c6-6e7382debbe1}" 
      Extensions = {
        Install = [
          # catpuccin-mocha theme
          "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-blue-git/latest.xpi"
        ];
      };
    };
    profiles.uday = {
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };
      search.force = true;

      #Example For bookmarks, will overwrite other bookmarks
      # bookmarks = [
      #   {
      #     name = "wikipedia";
      #     tags = [ "wiki" ];
      #     keyword = "wiki";
      #     url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
      #   }
      # ];

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.sessionstore.resume_from_crash" = true;
        "shimmer.disable-collapsing-sidebar" = true;
      };

      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        firefox-color
        ublock-origin
        sidebery
        youtube-shorts-block
        privacy-badger
        competitive-companion
        leechblock-ng
        user-agent-string-switcher
        tabliss
        tab-stash
      ];
    };
  };
}