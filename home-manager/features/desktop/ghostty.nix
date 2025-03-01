{
  config,
  ...
}: {
  programs.ghostty = {
    enable  = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };
}