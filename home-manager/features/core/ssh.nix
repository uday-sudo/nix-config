{
  outputs,
  lib,
  pkgs,
  config,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # optional, to avoid future defaults surprise

    matchBlocks = {
      "*" = {
        addKeysToAgent = lib.mkDefault "yes";
      };

      "hosts" = {
        host = "gitlab.com github.com git.homebox.com";
        identitiesOnly = false;
        identityFile = [
          "~/.ssh/id_ed25519"
          "~/.ssh/id_backup"
        ];
      };
    };
  };
}
