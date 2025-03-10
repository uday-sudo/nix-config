{
  config,
  pkgs,
  lib,
  ...
}: {
  # home.file.".config/gtk-3.0/settings.ini".force = true;
  # home.file.".config/gtk-4.0/settings.ini".force = true;
  # home.file.".gtkrc-2.0".force = true;

  # home.file.".gtkrc-2.0".force = true;
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
