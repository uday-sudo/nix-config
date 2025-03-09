{pkgs, ...}: {
  services.tumbler.enable = true;
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    gparted
    zenity
    # dunst
    libnotify
    wl-clipboard
    # wtype
    ydotool
  ];
}
