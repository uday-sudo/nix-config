{...}: {
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = ["btrfs" "fat32" "ntfs" "vfat"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1eef852a-8047-48ed-8e41-50edec7d6d31";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/F8B3-9773";
    fsType = "vfat";
  };

  swapDevices = [];
}
