{config, ...}:
{
  programs.bat = {
    enable = true;
    config.theme = "base16";
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [ "--color 16" ];

    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = config.programs.bash.enable;
  };

  programs.less.enable = true;
}
