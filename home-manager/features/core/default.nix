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
    ./lf.nix
    ./direnv.nix
    ./btop.nix
    ./eza.nix
    ./ssh.nix
    ./fzf.nix
    ./bat.nix
    ./tmux.nix
    ./zellij.nix
    ./fetch.nix
  ];

  home.packages = with pkgs; [
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
