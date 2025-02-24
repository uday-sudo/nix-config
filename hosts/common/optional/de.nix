{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
#   services.xserver.displayManager.lightdm.enable = true;
#   services.xserver.desktopManager.xfce.enable = true;

  # Enable KDE Plasma DE;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };
}
