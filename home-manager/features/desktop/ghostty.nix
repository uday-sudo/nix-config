{config, ...}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;

    settings = {
      font-size = 14;
      "clipboard-read" = "allow";
      "clipboard-write" = "allow";
      "background-opacity" = 0.75;
      "background-blur-radius" = 1;
      "cursor-style" = "block";
      "cursor-style-blink" = false;
      "cursor-invert-fg-bg" = true;
      "mouse-hide-while-typing" = true;
      "window-decoration" = true;
      "window-padding-balance" = true;
      "window-save-state" = "always";
    };
  };

  theme.ghostty.enable = true;
}
