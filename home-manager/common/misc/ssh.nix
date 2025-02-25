{ outputs, lib, ... }:
{
  programs.ssh = {
    enable = true;

    addKeysToAgent = "yes";

    matchBlocks = {
      "hosts" = {
        host = "gitlab.com github.com";
        identitiesOnly = false;
        identityFile = [
          "~/.ssh/id_ed25519"
        ];
      };
    };
  };
}