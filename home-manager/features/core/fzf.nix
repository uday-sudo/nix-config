{
  config,
  lib,
  ...
}: {
  programs.fzf = {
    enable = lib.mkDefault true;
    defaultOptions = ["--color 16"];

    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = config.programs.bash.enable;
  };
}
