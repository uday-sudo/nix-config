{pkgs, ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    comic-mono
    material-icons
    material-design-icons
  ];
}