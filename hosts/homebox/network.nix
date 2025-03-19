{...}: {
  networking = {
    hostName = "homebox";

    firewall = {
      # enable = false;
      allowPing = true;
    };
  };

  services.openssh = {
    settings = {
      AllowUsers = [ "hooman" "root" ];
    };
  };
}
