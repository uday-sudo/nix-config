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
  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };

  home.packages = with pkgs; [
    brave
    keepassxc
    # logseq
  ];
}
