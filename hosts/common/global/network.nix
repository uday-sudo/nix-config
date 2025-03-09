{lib, ...}: {
  networking = {
    hostName = "nixos";

    firewall = {
      enable = lib.mkDefault true;
      allowPing = lib.mkDefault true;
    };

    networkmanager.enable = lib.mkDefault true;
    useDHCP = lib.mkDefault true;
    # interfaces.wlp1s0.useDHCP = lib.mkDefault true;
  };

  services = {
    openssh.enable = lib.mkDefault true;
    tailscale.enable = true;
  };
}
