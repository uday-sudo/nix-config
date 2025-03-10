{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.theme;
in {
  options.theme = {
    enable = mkEnableOption "Enable theme configuration";

    scheme = mkOption {
      type = types.str;
      default = "Catppuccin";
      description = "Name of the color scheme";
    };
    flavor = mkOption {
      type = types.str;
      default = "Mocha";
      description = "Name of the color scheme flavor";
    };
    accent = mkOption {
      type = types.str;
      default = "Blue";
      description = "Name of the color scheme accent";
    };

    author = mkOption {
      type = types.str;
      default = "https://github.com/catppuccin/catppuccin";
      description = "Author of the color scheme";
    };

    colors = {
      base00 = mkOption {
        type = types.str;
        default = "#1e1e2e"; # base
        description = "Default background color";
      };

      base01 = mkOption {
        type = types.str;
        default = "#181825"; # mantle
        description = "Lighter background color";
      };

      base02 = mkOption {
        type = types.str;
        default = "#313244"; # surface0
        description = "Selection background color";
      };

      base03 = mkOption {
        type = types.str;
        default = "#45475a"; # surface1
        description = "Comments, invisibles, line highlighting";
      };

      base04 = mkOption {
        type = types.str;
        default = "#585b70"; # surface2
        description = "Dark foreground (status bars)";
      };

      base05 = mkOption {
        type = types.str;
        default = "#cdd6f4"; # text
        description = "Default foreground color";
      };

      base06 = mkOption {
        type = types.str;
        default = "#f5e0dc"; # rosewater
        description = "Light foreground (rarely used)";
      };

      base07 = mkOption {
        type = types.str;
        default = "#b4befe"; # lavender
        description = "Light background (rarely used)";
      };

      base08 = mkOption {
        type = types.str;
        default = "#f38ba8"; # red
        description = "Variables, XML tags, markup link text";
      };

      base09 = mkOption {
        type = types.str;
        default = "#fab387"; # peach
        description = "Integers, boolean, constants, XML attributes";
      };

      base0A = mkOption {
        type = types.str;
        default = "#f9e2af"; # yellow
        description = "Classes, markup bold, search text background";
      };

      base0B = mkOption {
        type = types.str;
        default = "#a6e3a1"; # green
        description = "Strings, inherited class, markup code";
      };

      base0C = mkOption {
        type = types.str;
        default = "#94e2d5"; # teal
        description = "Support, regular expressions, escape characters";
      };

      base0D = mkOption {
        type = types.str;
        default = "#89b4fa"; # blue
        description = "Functions, methods, attribute IDs, headings";
      };

      base0E = mkOption {
        type = types.str;
        default = "#cba6f7"; # mauve
        description = "Keywords, storage, selector, markup italic";
      };

      base0F = mkOption {
        type = types.str;
        default = "#f2cdcd"; # flamingo
        description = "Deprecated, opening/closing embedded language tags";
      };
    };
  };

  # config = mkIf cfg.enable {
  #   theme = {
  #     scheme = cfg.scheme;
  #     flavor = cfg.flavor;
  #     accent = cfg.accent;
  #     author = cfg.author;
  #     colors = cfg.colors;
  #   };
  # };
}
