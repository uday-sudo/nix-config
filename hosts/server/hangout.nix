{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [
    "jitsi-meet"
  ];

  services.owncast = {
    enable = false;
    port = 9990;
    listen = "0.0.0.0";
    group = "users";
  };

  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.homebox.com";
    # prosody.lockdown = true;
    config = {
      enableWelcomePage = false;
      prejoinPageEnabled = true;
      fileRecordingsEnabled = false;
      liveStreamingEnabled = true;
    };
    interfaceConfig = {
      SHOW_JITSI_WATERMARK = false;
      SHOW_WATERMARK_FOR_GUESTS = false;
    };
  };
  services.jitsi-videobridge.openFirewall = true;

  security.acme = {
    acceptTerms = true;
    defaults.email = "jovenjojo12@gmail.com";
  };

  services.nginx.virtualHosts."jitsi.homebox.com" = {
    enableACME = false;
    forceSSL = false;
  };
}