# configuration.nix

{ pkgs, inputs, config, ... }:

{

  imports =
    [
      inputs.sops-nix.nixosModules.sops
    ];

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "${config.users.users.uday.home}/.config/sops/age/keys.txt";
    };

    # secrets = {
    #   "root/sshPrivate".path = "/etc/ssh/ssh_host_ed25519_key";
    #   "root/sshPublic".path = "/etc/ssh/ssh_host_ed25519_key.pub";
    # };
  };

}
