{
  pkgs,
  config,
  inputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  sops.secrets = {
    "user_password/hooman".neededForUsers = true;
  };

  users.mutableUsers = false;
  users.users.hooman = {
    isNormalUser = true;
    description = "hooman";
    shell = pkgs.zsh;
    extraGroups =
      [
        "networkmanager"
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "network"
        "i2c"
        "git"
        "libvirtd"
        "podman"
        "media"
        "qbittorrent"
        "forgejo"
        "filebrowser"
        "syncthing"
        "olivetin"
        "immich"
      ];
    # The below is required so podman can perform userspace mappings
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];

    packages = with pkgs; [
    ];

    hashedPasswordFile = config.sops.secrets."user_password/hooman".path;
  };
}
