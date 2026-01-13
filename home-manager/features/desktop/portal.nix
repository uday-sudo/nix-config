{pkgs, ...}: {
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-hyprland
    ];

    config = {
      plasma = {
        default = ["kde"];
      };
      hyprland = {
        default = ["hyprland"];
      };
    };
  };
}
