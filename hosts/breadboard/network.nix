{...}: {
  networking = {
    hostName = "breadboard";

    firewall = {
      # enable = false;
      allowPing = true;
    };
  };

  # services.openssh.ports = [ 22 8022 ];
}
