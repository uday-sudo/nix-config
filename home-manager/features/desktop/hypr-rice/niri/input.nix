{...}: {
  programs.niri.settings.input = {
    keyboard.numlock = true;
    touchpad = {
      tap = true;
      natural-scroll = true;
      scroll-method = "edge";
    };
  };
}
