{
  config,
  lib,
  pkgs,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.trusted-users = [ "root" "uday" "hooman" ];
  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    vim
    neovim
    wget
    lz4
    sops
    age
    sshfs
    devenv
    caddy # reverse proxy
  ];
  programs.zsh = {
    enable = lib.mkDefault true;
    enableCompletion = true;
    autosuggestions = {
      enable = lib.mkDefault true;
      async = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    setOptions = lib.mkDefault [
      "AUTO_CD"
      "AUTO_LIST"
      "AUTO_MENU"
      "AUTO_PARAM_KEYS"
      "AUTO_PARAM_SLASH"
      "AUTO_REMOVE_SLASH"
      "AUTO_PUSHD"
      "CD_SILENT"
      "EXTENDED_HISTORY"
      "HIST_FCNTL_LOCK"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_DUPS"
      "PUSHD_IGNORE_DUPS"
      "RM_STAR_WAIT"
      "SHARE_HISTORY"
    ];
  };
  environment.pathsToLink = lib.mkIf config.programs.zsh.enable ["/share/zsh"];

  # To monitor and view power sources
  services.upower = {
    enable = lib.mkDefault true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = lib.mkDefault "/home/uday/gitjargan/nix-config";
  };

  programs.mtr.enable = lib.mkDefault true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [];
  };
}
