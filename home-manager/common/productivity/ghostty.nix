{
  config,
  ...
}: {
  programs.ghostty = {
    enable  = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableFishIntegration = config.programs.fish.enable;
  };
}