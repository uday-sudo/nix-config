{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.caddy = {
    virtualHosts."filebowser.homebox.com" = {
      extraConfig = ''
        reverse_proxy http://localhost:3030
        tls internal
      '';
    };
  };
  users.users.filebowser.isSystemUser = true;
  users.users.filebowser.group = "users";
  users.groups.filebowser = {};

  systemd.tmpfiles.rules = [
    "d /var/lib/filebowser 0770 filebowser filebowser"
    "d /var/lib/filebowser/storage 0770 filebowser filebowser"
  ];

  # re-login to take effect
  users.users.hooman.extraGroups = ["filebowser"];

  systemd.services.filebowser = {
    enable = true;
    after = ["network.target"];

    # The below line makes it not autstart on boot
    # wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "filebowser";
      Restart = "on-failure";
      ExecStart = ''
        ${pkgs.filebrowser}/bin/filebrowser \
          --port 3030 \
          --address 0.0.0.0 \
          --database /var/lib/filebowser/filebrowser.db \
          --root /run/media/hdd/
      '';
    };
  };
}
