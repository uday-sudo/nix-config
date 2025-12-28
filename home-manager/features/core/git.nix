{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    diff-so-fancy # Fancy diffs in lazygit
  ];

  theme.lazygit.enable = true;

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = lib.mkDefault "uday-sudo";
        user.email = lib.mkDefault "udayavengerdude@gmail.com";
        gpg.format = "ssh";
        alias = {
          co = "checkout";
          ci = "commit";
          st = "status";
          br = "branch";
          hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
          type = "cat-file -t";
          dump = "cat-file -p";
        };
      };
      lfs.enable = true;

      ignores = lib.mkDefault ["*.tmp" "*.temp" "tmp.*" "temp.*"];

      signing = {
        signByDefault = lib.mkDefault true;
        key = "${config.home.homeDirectory}/.ssh/sign_ed25519";
      };
    };

    lazygit = {
      enable = lib.mkDefault true;
      settings = {
        git = {
          pagers = [
            {
              colorArg = "always";
              pager = "diff-so-fancy";
            }
          ];
          autoFetch = true;
          skipHookPrefix = "WIP";
          parseEmoji = true;
        };
      };
    };
  };
}
