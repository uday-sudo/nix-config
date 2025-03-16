{
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # inputs.nixos-hardware.nixosModules.common-cpu-intel
  ];
}
