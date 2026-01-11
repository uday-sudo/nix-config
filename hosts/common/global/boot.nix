{
  lib,
  ...
}:
{
  boot.loader = {
    grub = {
      enable = lib.mkDefault true;
      efiSupport = lib.mkDefault true;
      device = lib.mkDefault "nodev";
      useOSProber = lib.mkDefault true;
      copyKernels = lib.mkDefault false;
    };
    efi.canTouchEfiVariables = lib.mkDefault true;
    efi.efiSysMountPoint = lib.mkDefault "/boot/efi";
  };
}
