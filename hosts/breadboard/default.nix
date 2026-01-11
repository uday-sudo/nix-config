{
  imports = [
    ../common/global
    ../common/optional/de.nix
    ../common/optional/fonts.nix
    ../common/optional/quietboot.nix
    ../common/optional/audio.nix
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
    ./services.nix
    ./wfh.nix
    ./boot.nix

    ../server/containers.nix
  ];

  hardware.steam-hardware.enable = true;

  system.stateVersion = "23.11";
}
