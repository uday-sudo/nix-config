{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  networking = {
    hostName = "homebox";

    firewall = {
      # enable = false;
      allowPing = true;
    };
  };

  services.openssh = {
    settings = {
      AllowUsers = ["hooman" "root" "forgejo" "git"];
    };
  };

  # Enable ipv4 forwarding on the exit nodes.
  services.tailscale.useRoutingFeatures = "both";

  # Enable UDP layer optimizations for tailscale.
  environment.systemPackages = [
    pkgs.ethtool
    pkgs.networkd-dispatcher
  ];

  services = {
    networkd-dispatcher = {
      enable = true;
      rules."50-tailscale" = {
        onState = ["routable"];
        script = ''
          ${lib.getExe pkgs.ethtool} -K eth0 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };
  };
}
