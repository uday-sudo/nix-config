{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./cli
    ./shell.nix
    ./git.nix
    ./misc.nix
    ./lf.nix
    ./direnv.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    neofetch

    # archives
    zip
    xz
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    brave
    starship #Prompt
    kate

    # misc
    cowsay
    which
    tree
    gnused
    gnutar
    gawk
    zstd

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    pciutils # lspci
    usbutils # lsusb
  ];
}
