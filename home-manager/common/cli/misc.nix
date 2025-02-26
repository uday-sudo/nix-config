{
  programs.bat = {
    enable = true;
    config.theme = "base16";
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [ "--color 16" ];
  };

  programs.less.enable = true;
}
