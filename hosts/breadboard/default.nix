{config, ...}: {
  sops.secrets."host_password/breadboard".neededForUsers = true;

  imports = [
    ../common/global
    ../common/optional/de.nix
    ../common/optional/fonts.nix
    ../common/optional/quietboot.nix
    ../common/optional/audio.nix
    ../common/users/uday

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

    # hardware specific import
    ./hp.nix

    # Asus specific import
    # ./asusctl.nix
    # ./battery.nix

    ../server/containers.nix
  ];

  users.users.root.hashedPasswordFile = config.sops.secrets."host_password/breadboard".path;

  hardware.steam-hardware.enable = true;

  system.stateVersion = "26.05";
}
