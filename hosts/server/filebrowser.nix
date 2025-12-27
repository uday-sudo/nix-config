{
  inputs,
  config,
  pkgs,
  ...
}: let
  domain = config.homebox.domain;
  svcName = "filebowser";
  hostName = "${svcName}.${domain}";
  port = 3030;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.caddy = {
    virtualHosts."${hostName}" = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString port}
        tls internal
      '';
    };
  };

  users.users."${svcName}" = {
    isSystemUser = true;
    group = "users";
  };
  users.groups."${svcName}" = {};

  systemd.tmpfiles.rules = [
    "d /var/lib/${svcName} 0770 ${svcName} ${svcName}"
    "d /var/lib/${svcName}/storage 0770 ${svcName} ${svcName}"
  ];

  # re-login to take effect
  users.users.hooman.extraGroups = ["${svcName}"];

  systemd.services."${svcName}" = {
    enable = true;
    after = ["network.target"];

    # The below line makes it not autstart on boot
    # wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "${svcName}";
      Restart = "on-failure";
      ExecStart = ''
        ${pkgs.filebrowser}/bin/filebrowser \
          --port ${toString port} \
          --address 0.0.0.0 \
          --database /var/lib/${svcName}/filebrowser.db \
          --root /run/media/hdd/
      '';
    };
  };
}
