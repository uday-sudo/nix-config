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
      # Home key
      bindkey "^[OH" beginning-of-line
      # End key
      bindkey "^[OF" end-of-line
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
      lazypodman = "DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker";
    };
    sessionVariables = {
      TERMINAL = "ghostty";
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
    };
  };
}
