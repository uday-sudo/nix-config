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
    ./starship.nix
    ./git.nix
    ./lf.nix
    ./direnv.nix
    ./btop.nix
    ./eza.nix
    ./ssh.nix
    ./fzf.nix
    ./bat.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    neofetch

    zip
    xz
    unzip

    # utils
    ripgrep
    jq

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
