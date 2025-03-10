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
      userName = lib.mkDefault "uday-sudo";
      userEmail = lib.mkDefault "udayavengerdude@gmail.com";

      ignores = lib.mkDefault ["*.tmp" "*.temp" "tmp.*" "temp.*"];

      signing = {
        signByDefault = lib.mkDefault true;
        key = "${config.home.homeDirectory}/.ssh/sign_ed25519";
      };

      extraConfig.gpg.format = "ssh";

      aliases = {
        co = "checkout";
        ci = "commit";
        st = "status";
        br = "branch";
        hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
        type = "cat-file -t";
        dump = "cat-file -p";
      };
    };

    lazygit = {
      enable = lib.mkDefault true;
      settings = {
        # gui.theme = {
        #   activeBorderColor = ["#89b4fa" "bold"];
        #   inactiveBorderColor = ["#a6adc8"];
        #   optionsTextColor = ["#89b4fa"];
        #   selectedLineBgColor = ["#313244"];
        #   cherryPickedCommitBgColor = ["#45475a"];
        #   cherryPickedCommitFgColor = ["#89b4fa"];
        #   unstagedChangesColor = ["#f38ba8"];
        #   defaultFgColor = ["#cdd6f4"];
        #   searchingActiveBorderColor = ["#f9e2af"];
        # };

        # authorColors = {
        #   "*" = "#b4befe";
        # };

        git = {
          paging = {
            colorArg = "always";
            pager = "diff-so-fancy";
          };
          autoFetch = true;
          skipHookPrefix = "WIP";
          parseEmoji = true;
        };
      };
    };
  };
}
