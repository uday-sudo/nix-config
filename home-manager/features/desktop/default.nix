{pkgs, ...}: {
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./mpv.nix
    ./firefox
    ./cursor.nix
    ./plasma.nix
    ./syncthing.nix
    ./hypr-rice
    ./portal.nix
  ];

  programs.vesktop.enable = true;

  home.packages = with pkgs; [
    brave
    keepassxc
    obsidian
    # logseq
  ];
}
