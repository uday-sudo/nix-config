{
  sources,
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  #zsh
  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    # autosuggestion.enable = true;

    # My prefered keybinds
    initContent = lib.mkOrder 1200 ''
      # Use terminfo first so key bindings follow the active terminal.
      [[ -n ''${terminfo[khome]} ]] && bindkey "''${terminfo[khome]}" beginning-of-line
      [[ -n ''${terminfo[kend]} ]] && bindkey "''${terminfo[kend]}" end-of-line
      # Common fallback sequences used by terminals and by tmux.
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[OH" beginning-of-line
      bindkey "^[OF" end-of-line
      bindkey "^[[1~" beginning-of-line
      bindkey "^[[4~" end-of-line
      # Delete key
      bindkey "^[[3~" delete-char
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
  };

  home = {
    shellAliases = {
      reborn = "reboot";
      die = "shutdown -P now";
      pls = "sudo";
      icat = "kitten icat";
    };
    sessionVariables = {
      TERMINAL = "ghostty";
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };
}
