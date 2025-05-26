{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.caddy = {
    virtualHosts."jellyfin.homebox.com" = {
      extraConfig = ''
        reverse_proxy http://localhost:8096
        tls internal
      '';
    };
  };

  # # 1. enable vaapi on OS-level
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # Or "i965" if using older driver
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      # OpenCL support for intel CPUs before 12th gen
      # see: https://github.com/NixOS/nixpkgs/issues/356535
      intel-media-sdk # QSV up to 11th gen
      intel-ocl
    ];
  };
  services.jellyfin = {
    enable = true;
    dataDir = "/run/media/hdd/jellyfin";
    user = "hooman";
    openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  systemd.services.jellyfin.wantedBy = lib.mkForce [];
}
