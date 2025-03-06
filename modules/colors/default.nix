{ config, lib, ... }:

with lib;

let
  cfg = config.theme;
in {
  options.theme = {
    enable = mkEnableOption "Enable theme configuration";

    colors = {
      accent = mkOption {
        type = types.str;
        default = "#89b4fa";
        description = "Primary accent color";
      };

      text = mkOption {
        type = types.str;
        default = "#cdd6f4";
        description = "Primary text color";
      };

      subtext1 = mkOption {
        type = types.str;
        default = "#bac2de";
        description = "Subtext 1 color";
      };

      subtext0 = mkOption {
        type = types.str;
        default = "#a6adc8";
        description = "Subtext 0 color";
      };

      overlay2 = mkOption {
        type = types.str;
        default = "#9399b2";
        description = "Overlay 2 color";
      };

      overlay1 = mkOption {
        type = types.str;
        default = "#7f849c";
        description = "Overlay 1 color";
      };

      overlay0 = mkOption {
        type = types.str;
        default = "#6c7086";
        description = "Overlay 0 color";
      };

      surface2 = mkOption {
        type = types.str;
        default = "#585b70";
        description = "Surface 2 color";
      };

      surface1 = mkOption {
        type = types.str;
        default = "#45475a";
        description = "Surface 1 color";
      };

      surface0 = mkOption {
        type = types.str;
        default = "#313244";
        description = "Surface 0 color";
      };

      base = mkOption {
        type = types.str;
        default = "#1e1e2e";
        description = "Base color";
      };

      mantle = mkOption {
        type = types.str;
        default = "#181825";
        description = "Mantle color";
      };

      crust = mkOption {
        type = types.str;
        default = "#11111b";
        description = "Crust color";
      };
    };
  };

  config = mkIf cfg.enable {
    # You can add configurations here that depend on the theme
    # For example, setting environment variables or configuring applications
  };
}