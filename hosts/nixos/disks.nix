{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];
}
