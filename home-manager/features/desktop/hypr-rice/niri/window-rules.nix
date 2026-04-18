{...}: {
  programs.niri.settings.window-rules = [
    {
      draw-border-with-background = false;
    }
    {
      matches = [{app-id = "^org\\.wezfurlong\\.wezterm$";}];
      default-column-width = {};
    }
    {
      matches = [{app-id = "firefox$"; title = "^Picture-in-Picture$";}];
      open-floating = true;
    }
  ];
}
