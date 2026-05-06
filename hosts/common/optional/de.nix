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
  imports = [
    inputs.niri.nixosModules.niri
  ];

  systemd.user.services.niri-flake-polkit.enable = false;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  programs.niri.enable = true;

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
        wayland.enable = true;
        autoNumlock = true;
      };
      defaultSession = "niri";
    };

    desktopManager.plasma6.enable = false;
    desktopManager.gnome.enable = true;

    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  environment.systemPackages = with pkgs; [
    custom-sddm-astronaut
    xwayland-satellite
    kdePackages.qtmultimedia
    nemo
    loupe
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
