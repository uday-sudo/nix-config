{pkgs, ...}: {
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    config = {
      plasma = {
        default = ["kde"];
      };
    };
  };
}
