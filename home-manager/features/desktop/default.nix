{
  pkgs,
  ...
}: {
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

  home.packages = with pkgs; [
    brave
    keepassxc
    obsidian
    # logseq
  ];
}
