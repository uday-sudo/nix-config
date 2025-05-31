{pkgs, ...}: {
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable KDE Plasma DE;
  services = {
    displayManager = {
      sddm = {
        enable = true;
        theme = "catppuccin-sddm-corners";
      };
      defaultSession = "plasma";
    };

    desktopManager.plasma6.enable = true;

    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
    kate
    elisa
    kwallet
    kwallet-pam
    kwalletmanager
  ];
}
