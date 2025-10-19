{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.theme.oh-my-posh;
in {
  options.theme.oh-my-posh = {
    enable = mkEnableOption "Enable oh-my-posh theme configuration";

    configFile = mkOption {
      type = types.enum ["emodipt-extend" "amro" "pure"];
      default = "emodipt-extend";
      description = "Name of the JSON config file (without .json extension) to use from the configs folder";
    };
  };

  config = mkIf cfg.enable {
    programs.oh-my-posh = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableZshIntegration = config.programs.zsh.enable;
      settings = builtins.fromJSON (
        builtins.readFile (./ompconfigs + "/${cfg.configFile}.json")
      );
    };
  };
}
