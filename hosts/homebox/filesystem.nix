{ lib, config, inputs, ... }:
{
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = ["btrfs" "fat32" "ntfs" "vfat"];
  };
  swapDevices = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ac4c24fd-5e89-4643-9421-019901872d32";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/F7D8-60FA";
    fsType = "vfat";
  };

  fileSystems."/run/media/hdd" = {
    device = "/dev/disk/by-uuid/5ae28103-bcb7-407e-8f18-744f59057aee";
  };
  # for nixos-anywhere
  # disko.devices = {
  #   disk.disk1 = {
  #     device = lib.mkDefault "/dev/sda";
  #     type = "disk";
  #     content = {
  #       type = "gpt";
  #       partitions = {
  #         boot = {
  #           name = "boot";
  #           size = "1M";
  #           type = "EF02";
  #         };
  #         esp = {
  #           name = "ESP";
  #           size = "500M";
  #           type = "EF00";
  #           content = {
  #             type = "filesystem";
  #             format = "vfat";
  #             mountpoint = "/boot";
  #           };
  #         };
  #         root = {
  #           name = "root";
  #           size = "100%";
  #           content = {
  #             type = "filesystem";
  #             format = "ext4";
  #             mountpoint = "/";
  #           };
  #         };
  #       };
  #     };
  #   };
  # };
}