{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float,class:^(qt5ct)$"
      "float,class:^(nwg-look)$"
      "float,class:^(org.kde.ark)$"
      "float,class:^(Signal)$" # Signal-Gtk
      "float,class:^(com.github.rafostar.Clapper)$" # Clapper-Gtk
      "float,class:^(app.drey.Warp)$" # Warp-Gtk
      "float,class:^(net.davidotek.pupgui2)$" # ProtonUp-Qt
      "float,class:^(yad)$" # Protontricks-Gtk
      "float,class:^(eog)$" # Imageviewer-Gtk
      "float,class:^(io.gitlab.theevilskeleton.Upscaler)$" # Upscaler-Gtk
      "float,class:^(pavucontrol)$"
      "float,class:^(blueman-manager)$"
      "float,class:^(nm-applet)$"
      "float,class:^(nm-connection-editor)$"
      "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
      "float,class:^(satty)$"
    ];
    layerrule = [
      "blur on, match:namespace powermenu"
      "blur on, match:namespace rofi"
    ];
  };
}
