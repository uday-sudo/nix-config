{ config, ...}:
{
  programs = {
    git = {
      enable = true;
      userName = "uday-sudo";
      userEmail = "udayavengerdude@gmail.com";

      signing = {
        signByDefault = true;
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

    gitui = {
      enable = true;
      theme = ''
      (
        selected_tab: Some("Reset"),
        command_fg: Some("#cdd6f4"),
        selection_bg: Some("#585b70"),
        selection_fg: Some("#cdd6f4"),
        cmdbar_bg: Some("#181825"),
        cmdbar_extra_lines_bg: Some("#181825"),
        disabled_fg: Some("#7f849c"),
        diff_line_add: Some("#a6e3a1"),
        diff_line_delete: Some("#f38ba8"),
        diff_file_added: Some("#a6e3a1"),
        diff_file_removed: Some("#eba0ac"),
        diff_file_moved: Some("#cba6f7"),
        diff_file_modified: Some("#fab387"),
        commit_hash: Some("#b4befe"),
        commit_time: Some("#bac2de"),
        commit_author: Some("#74c7ec"),
        danger_fg: Some("#f38ba8"),
        push_gauge_bg: Some("#89b4fa"),
        push_gauge_fg: Some("#1e1e2e"),
        tag_fg: Some("#f5e0dc"),
        branch_fg: Some("#94e2d5")
      )
      '';
    };
  };


}