{
  pkgs,
  lib,
  inputs,
  ...
}: let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
    themeConfig = {
      AllowUppercaseLettersInUsernames = "true";
      Background = "${inputs.wallpapers}/regular/042.jpg";
    };
  };
in {
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable KDE Plasma DE;
  services = {
    displayManager = {
      sddm = {
        enable = true;
        package = lib.mkForce pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
        extraPackages = [
          custom-sddm-astronaut
        ];
        # wayland.enable = true;
        autoNumlock = true;
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
    custom-sddm-astronaut
    kdePackages.qtmultimedia
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
    kate
    elisa
    kwallet
    kwallet-pam
    kwalletmanager
  ];
}
