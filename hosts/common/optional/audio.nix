{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    helvum
    pavucontrol
    easyeffects
  ];

  # Enable sound with pipewire.
  # sound.enable = true; #Only meant for ALSA based configurations
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire.adjust-sample-rate = {
      "context.properties" = {
        # "default.clock.rate" = 192000;
        #"defautlt.allowed-rates" = [ 192000 48000 44100 ];
        # "defautlt.allowed-rates" = [ 192000 ];
        #"default.clock.quantum" = 32;
        "default.clock.min-quantum" = 1024;
        #"default.clock.max-quantum" = 32;
      };
    };
    wireplumber = {
      # TODO: check out NixOS wiki for updates on this
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
          	["bluez5.enable-sbc-xq"] = true,
          	["bluez5.enable-msbc"] = true,
          	["bluez5.enable-hw-volume"] = true,
          	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
        '')
      ];
    };
  };
}
