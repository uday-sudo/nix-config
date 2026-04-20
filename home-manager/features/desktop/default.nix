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
    vaults.Notes.target = "SYNC/vault/Notes";
  };

  home.packages = with pkgs; [
    brave
    keepassxc
    # logseq
  ];
}
