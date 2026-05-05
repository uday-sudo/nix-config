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

  fonts.fontconfig.enable = true;

  programs.vesktop.enable = true;
  services.easyeffects.enable = true;
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
