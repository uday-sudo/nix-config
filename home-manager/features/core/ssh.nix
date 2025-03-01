{ outputs, lib, pkgs, config, ... }:
{
  programs.ssh = {
    enable = true;

    addKeysToAgent = lib.mkDefault "yes";

    matchBlocks = {
      "hosts" = {
        host = "gitlab.com github.com";
        identitiesOnly = false;
        identityFile = [
          "~/.ssh/id_ed25519"
          "~/.ssh/id_backup"
        ];
      };
    };
  };
}