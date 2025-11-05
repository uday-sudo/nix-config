{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.theme.lazydocker;
  theme = config.theme.colors;
in {
  options.theme.lazydocker = {
    enable = mkEnableOption "Enable lazydocker theme configuration";
  };

  config = mkIf cfg.enable {
    programs.lazydocker = {
      enable = true;

      settings = {
        gui.theme = {
          activeBorderColor = ["${theme.base0D}" "bold"];
          inactiveBorderColor = ["${theme.base04}"];
          optionsTextColor = ["${theme.base0D}"];
          selectedLineBgColor = ["${theme.base02}"];
          cherryPickedCommitBgColor = ["${theme.base03}"];
          cherryPickedCommitFgColor = ["${theme.base0D}"];
          unstagedChangesColor = ["${theme.base08}"];
          defaultFgColor = ["${theme.base05}"];
          searchingActiveBorderColor = ["${theme.base0A}"];
        };

        authorColors = {
          "*" = "${theme.base07}"; # lavender
        };
      };
    };
  };
}
