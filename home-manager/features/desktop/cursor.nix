{
  config,
  pkgs,
  lib,
  ...
}: {
  # home.file."~/.gtkrc-2.0".force = true;
  # gtk = {
  # enable = true;
  # cursorTheme = {
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Ice";
  #   size = 24;
  # };
  # };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    x11.enable = true;
  };
}
