{
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../common/global
    ../common/users/uday

    ./battery.nix
    ./asusctl.nix
    ./bluetooth.nix
    ./cpu.nix
    ./gpu.nix
    ./dev.nix
    ./disks.nix
    ./gui.nix
    ./filesystem.nix
    ./network.nix
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [];
  };
  system.stateVersion = "23.11";
}
