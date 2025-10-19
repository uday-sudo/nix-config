{
  pkgs,
  config,
  inputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  sops.secrets = {
    "user_password/uday".neededForUsers = true;
  };

  users.mutableUsers = false;
  users.users.uday = {
    isNormalUser = true;
    description = "Uday";
    shell = pkgs.zsh;
    extraGroups =
      [
        "networkmanager"
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "minecraft"
        "podman"
        "network"
        "i2c"
        "git"
        "libvirtd"
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
      home-manager

      discord
      spotify

      # yes i like chess
      # en-croissant
    ];

    hashedPasswordFile = config.sops.secrets."user_password/uday".path;
  };

  programs.gaming = {
    enable = true;
    enableWine = false;
  };
}
