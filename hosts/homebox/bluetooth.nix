{config, ...}: {
  services.blueman.enable = false;
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
  };
}
