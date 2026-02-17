{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-cpu-intel-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  # Enables ACPI platform profiles on HP (kernel >= 6.1)
  boot = lib.mkIf (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.1") {
    kernelModules = ["hp-wmi"];
  };

  # Charge limit support requires firmware exposing the threshold sysfs interface.
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 60;
    };
  };
}
