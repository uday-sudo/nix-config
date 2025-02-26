{ pkgs, inputs, config, ... }:
let
  secretspath = builtins.toString inputs.mysecrets;
in
{

  imports =
    [
      inputs.sops-nix.nixosModules.sops
    ];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };

    "${config.home.username}/sshPrivate".path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    "${config.home.username}/sshPublic".path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";

    "${config.home.username}/signPrivate".path = "${config.home.homeDirectory}/.ssh/sign_ed25519";
    "${config.home.username}/signPublic".path = "${config.home.homeDirectory}/.ssh/sign_ed25519.pub";
  };

}
