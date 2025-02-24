{ pkgs, config, inputs, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [ ./packages.nix ];

  sops.secrets = {
    "user_password/uday".neededForUsers = true;

    # ssh keys
    "uday/sshPrivate" = {
      owner = config.users.users.uday.name;
      path = "${config.users.users.uday.home}/.ssh/id_ed25519";
    };
    "uday/sshPublic" = {
      owner = config.users.users.uday.name;
      path = "${config.users.users.uday.home}/.ssh/id_ed25519.pub";
    };


    "uday/signPrivate" = {
      owner = config.users.users.uday.name;
      path = "${config.users.users.uday.home}/.ssh/sign_ed25519";
    };
    "uday/signPublic" = {
      owner = config.users.users.uday.name;
      path = "${config.users.users.uday.home}/.ssh/sign_ed25519.pub";
    };
  };

  users.mutableUsers = false;
  users.users.uday = {
    isNormalUser = true;
    description = "Uday";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "minecraft"
      "network"
      "i2c"
      "git"
      "libvirtd"
    ];

    packages = [ pkgs.home-manager ];
    hashedPasswordFile = config.sops.secrets."user_password/uday".path;
  };
}
