{
  wayland.windowManager.hyprland = {
    settings.layerrule = [
      "blur on, match:namespace powermenu"
      "blur on, match:namespace rofi"
    ];

    extraConfig = ''
      windowrule {
        name = float-qt5ct
        float = true
        match:class = ^(qt5ct)$
      }
      windowrule {
        name = float-nwg-look
        float = true
        match:class = ^(nwg-look)$
      }
      windowrule {
        name = float-ark
        float = true
        match:class = ^(org.kde.ark)$
      }
      windowrule {
        name = float-signal
        float = true
        match:class = ^(Signal)$
      }
      windowrule {
        name = float-clapper
        float = true
        match:class = ^(com.github.rafostar.Clapper)$
      }
      windowrule {
        name = float-warp
        float = true
        match:class = ^(app.drey.Warp)$
      }
      windowrule {
        name = float-pupgui2
        float = true
        match:class = ^(net.davidotek.pupgui2)$
      }
      windowrule {
        name = float-yad
        float = true
        match:class = ^(yad)$
      }
      windowrule {
        name = float-eog
        float = true
        match:class = ^(eog)$
      }
      windowrule {
        name = float-upscaler
        float = true
        match:class = ^(io.gitlab.theevilskeleton.Upscaler)$
      }
      windowrule {
        name = float-pavucontrol
        float = true
        match:class = ^(pavucontrol)$
      }
      windowrule {
        name = float-blueman
        float = true
        match:class = ^(blueman-manager)$
      }
      windowrule {
        name = float-nm-applet
        float = true
        match:class = ^(nm-applet)$
      }
      windowrule {
        name = float-nm-connection-editor
        float = true
        match:class = ^(nm-connection-editor)$
      }
      windowrule {
        name = float-polkit-kde
        float = true
        match:class = ^(org.kde.polkit-kde-authentication-agent-1)$
      }
      windowrule {
        name = float-satty
        float = true
        match:class = ^(satty|com.gabm.satty)$
      }
    '';
  };
}
