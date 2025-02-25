# configuration.nix

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
      keyFile = "/var/lib/sops-nix/key.txt";
    };

    # secrets = {
    #   "root/sshPrivate".path = "/etc/ssh/ssh_host_ed25519_key";
    #   "root/sshPublic".path = "/etc/ssh/ssh_host_ed25519_key.pub";
    # };
  };

}
