{
  pkgs,
  lib,
  ...
}: {
  services.zerotierone = {
    enable = true;
    joinNetworks = ["88c5b1f33943beff"];
  };

  systemd.services.zerotierone.wantedBy = lib.mkForce [];

  environment.systemPackages = [
    pkgs.remmina
    pkgs.rustdesk-flutter
  ];
}
