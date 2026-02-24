{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  domain = config.homebox.domain;
  svcName = "sync";
  port = 8384;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.caddy = {
    virtualHosts."${svcName}.${domain}" = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString port}
        tls internal
      '';
    };
  };
  services.syncthing = {
    group = "users";
    guiAddress = "0.0.0.0:${toString port}";
    enable = true;

    settings = {
      devices = {
        "laptop" = {
          id = "RVVEIF5-YZ4IDJ6-ZFFJTV5-NEABCHB-U7B6R3Y-JD5ZJZ3-LPS52VH-N3DXWQP";
        };
        "phone" = {
          id = "ZQWSMLR-YLJZIC7-RJGE2N4-V3BBW2P-NCSUFJ5-BYK7P32-4VCRBUZ-FFJ53A4";
        };
      };

      folders = {
        "keepass" = {
          path = "/run/media/hdd/SYNC/keepass";
          devices = ["laptop" "phone"];
          versioning = {
            type = "simple";
            params.keep = "10";
          };
        };

        "vault" = {
          path = "/run/media/hdd/SYNC/vault";
          devices = ["laptop" "phone"];
          versioning = {
            type = "simple";
            params.keep = "40";
          };
        };
      };

      gui = {
        user = "hooman";
        password = "12345678";
      };
    };
  };
}
