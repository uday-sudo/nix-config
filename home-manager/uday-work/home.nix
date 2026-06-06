{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    ../features/core
    ../features/desktop/ghostty.nix
    ../features/productivity/neovim
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.nur.overlays.default

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "uday";
    homeDirectory = "/home/uday";
    sessionPath = [
      "$HOME/.nix-profile/bin"
    ];

    shellAliases = lib.mkForce {
      reborn = "reboot";
      die = "shutdown -P now";
      pls = "sudo";
      icat = "kitten icat";
      tmux = "tmux -u";
    };
    sessionVariables = lib.mkForce {
      TERMINAL = "ghostty";
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      LANG = "en_IN.UTF-8";
      LC_ALL = "en_IN.UTF-8";
      LC_CTYPE = "en_IN.UTF-8";
    };
  };

  programs.git.enable = lib.mkForce false;
  programs.ssh.enable = lib.mkForce false;
  programs.ghostty.package = null;
  programs.ghostty.systemd.enable = false;
  programs.ghostty.settings."background-opacity" = lib.mkForce 1.0;
  programs.ghostty.settings."background-blur-radius" = lib.mkForce 0;
  programs.ghostty.settings."window-decoration" = lib.mkForce true;
  programs.tmux.extraConfig = lib.mkAfter ''
    set -g status-left ""
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_green}] #S "
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0},none]|"
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_maroon}] #{pane_current_command} "
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0},none]|"
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_blue}] #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "

    set -g status-right ""
    set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_mauve}] #U@#H "
    set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0},none]|"
    set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_blue}] %Y-%m-%d %H:%M "

    set -g @catppuccin_window_text "#[fg=#{@thm_rosewater},bg=#{@thm_mantle}] #I#{?#{!=:#{window_name},},: #W,}"
    set -g @catppuccin_window_current_text "#[fg=#{@thm_mantle},bg=#{@thm_peach}] #I#{?#{!=:#{window_name},},: #W,}"
  '';
  programs.zsh.initContent = lib.mkAfter ''
    [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
    [ -f "$HOME/gitjargan/uday_scripts/script_runner.sh" ] && source "$HOME/gitjargan/uday_scripts/script_runner.sh"

    if [ -n "$SSH_CONNECTION" ]; then
      IP=$(echo "$SSH_CONNECTION" | awk '{print $1}')
      USER=$(whoami)
      HOST=$(hostname)

      DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus \
        notify-send "SSH Login Alert" "User: $USER\nFrom: $IP\nHost: $HOST"

      if command -v script >/dev/null 2>&1; then
        script notify --ip "$IP" "I know who you are" "I will find you"
      fi

      play -n \
        synth 0.2 sine C5 : \
        synth 0.2 sine E5 : \
        synth 0.2 sine G5 : \
        synth 0.35 sine C6 \
        fade h 0.02 1 0.1 reverb 50 >/dev/null 2>&1

      echo -e "\a"
    fi
  '';

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.packages = with pkgs; [
    libnotify
    sox
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";

  #colorscheme module
  theme.enable = true;
  theme.fastfetch.enableShellStartup = false;
  theme.fastfetch.useWallpaperLogo = false;
  theme.oh-my-posh = {
    enable = true;
    configFile = "peru";
  };
}
