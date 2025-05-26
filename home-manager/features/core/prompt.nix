{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.oh-my-posh = {
    enable = true;

    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;

    settings = builtins.fromJSON (builtins.readFile ./ohmyposh.json);
  };
}
