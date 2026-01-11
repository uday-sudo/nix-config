{
  # Using systemd-boot for secure-boot support
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 20;
  };
}
