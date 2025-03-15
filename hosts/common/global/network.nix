{lib, ...}: {
  networking = {
    hostName = lib.mkDefault "nixos";

    firewall = {
      enable = lib.mkDefault false;
      allowPing = lib.mkDefault true;
    };

    networkmanager.enable = lib.mkDefault true;
    useDHCP = lib.mkDefault true;
    # interfaces.wlp1s0.useDHCP = lib.mkDefault true;
  };

  services.tailscale.enable = true;
  services.openssh = {
    allowSFTP = lib.mkDefault true;
    enable = lib.mkDefault true;
    ports = lib.mkDefault [ 22 8022 ];
    settings = {
      PasswordAuthentication = lib.mkDefault true;
      UseDns = lib.mkDefault true;
      X11Forwarding = lib.mkDefault false;
      PermitRootLogin = lib.mkDefault "yes";
    };
  };
}
