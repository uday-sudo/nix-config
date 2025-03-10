{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.theme.ghostty;
  theme = config.theme;
in {
  options.theme.ghostty = {
    enable = mkEnableOption "Enable Ghostty theme configuration";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      settings.theme = "${toLower theme.scheme}-${toLower theme.flavor}";
      themes = {
        "${lib.toLower theme.scheme}-${lib.toLower theme.flavor}" = {
          background = "${theme.colors.base00}";
          cursor-color = "${theme.colors.base06}";
          foreground = "${theme.colors.base05}";
          palette = [
            "0=${theme.colors.base03}"
            "1=${theme.colors.base08}"
            "2=${theme.colors.base0B}"
            "3=${theme.colors.base0A}"
            "4=${theme.colors.base0D}"
            "5=${theme.colors.base0E}"
            "6=${theme.colors.base0C}"
            "7=${theme.colors.base05}"
            "8=${theme.colors.base04}"
            "9=${theme.colors.base08}"
            "10=${theme.colors.base0B}"
            "11=${theme.colors.base0A}"
            "12=${theme.colors.base0D}"
            "13=${theme.colors.base0E}"
            "14=${theme.colors.base0C}"
            "15=${theme.colors.base05}"
          ];
          selection-background = "${theme.colors.base02}";
          selection-foreground = "${theme.colors.base05}";
        };
      };
    };
  };
}
