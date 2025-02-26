{ pkgs, config, inputs, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [ ./packages.nix ];

  sops.secrets = {
    "user_password/uday".neededForUsers = true;
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
