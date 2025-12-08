{...}: {
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = ["btrfs" "fat32" "ntfs" "vfat"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a71acdd5-a07b-415d-93bd-0a742f2a944e";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/E5B1-9DFA";
    fsType = "vfat";
  };

  swapDevices = [];
}
