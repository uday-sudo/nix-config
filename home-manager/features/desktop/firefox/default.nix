{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.file."${config.home.homeDirectory}/.mozilla/firefox/uday/chrome".source = inputs.firefox-theme;

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisplayBookmarksToolbar = "never";
      SearchBar = "unified";
      ExtensionSettings = {
        # "*".installation_mode = "blocked";
        "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-blue-git/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.uday = {
      search = {
        force = true;
        engines = {
          # don't need these default ones
          "amazondotcom-us".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "google" = {
            urls = [
              {
                template = "https://google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [",g"];
          };
          "ddg" = {
            urls = [
              {
                template = "https://duckduckgo.com";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [",d"];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["ho"];
          };
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["np"];
          };
          "youtube" = {
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["y"];
          };
          "Wikipedia" = {
            urls = [
              {
                template = "https://en.wikipedia.org/wiki/Special:Search";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["wik"];
          };
          "DockerHub" = {
            urls = [
              {
                template = "https://hub.docker.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["dh"];
          };
          "GitHub" = {
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["gh"];
          };
        };
        default = "google";
      };

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
        "shimmer.disable-collapsing-sidebar" = true;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.sessionstore.resume_from_crash" = true;
        "app.update.auto" = true;
        "browser.download.panel.shown" = true;
        "browser.quitShortcut.disabled" = true; # disable ctrl+q

        # Disable telemetry
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;

        # other
        "media.autoplay.default" = 0; # enable autoplay on open
        "devtools.toolbox.host" = "right"; # move devtools to right
        "media.rdd-vpx.enabled" = true; # enable hardware acceleration
        "devtools.cache.disabled" = true; # disable caching in devtools
        "media.ffmpeg.vaapi.enabled" = true; # enable hardware acceleration
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        firefox-color
        ublock-origin
        sidebery
        # youtube-shorts-block
        web-clipper-obsidian
        tweaks-for-youtube
        privacy-badger
        competitive-companion
        leechblock-ng
        user-agent-string-switcher
        tabliss
        tab-stash
        keepassxc-browser
      ];
    };
  };
}
