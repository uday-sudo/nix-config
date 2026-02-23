# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports =
    [
      #TODO zsh ./fish.nix
      ./sops.nix
      ./locale.nix
      ./nix.nix
      ./boot.nix
      ./filesystem.nix
      ./packages.nix
      ./bluetooth.nix
      ./network.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  #home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  # Fix for qt6 plugins
  # TODO: maybe upstream this?
  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
  };

  hardware.enableRedistributableFirmware = true;

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  programs.mtr.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
