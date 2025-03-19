{
  outputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../common/global
    ../server

    ../common/users/hooman

    ./bluetooth.nix
    ./cpu.nix
    ./dev.nix
    ./disks.nix
    ./filesystem.nix
    ./network.nix
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ8yGpF8gsJNiJy6rWB5b1ZFS8xKQcPhxB3iW9Te7CKP uday@nixos"
  ];


  users.users.hooman.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ8yGpF8gsJNiJy6rWB5b1ZFS8xKQcPhxB3iW9Te7CKP uday@nixos"
  ];

  programs.nh.flake = "${config.users.users.hooman.home}/gitjargan/nix-config";
  system.stateVersion = "24.05";
}
