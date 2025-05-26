{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.caddy = {
    virtualHosts."sync.homebox.com" = {
      extraConfig = ''
        reverse_proxy http://localhost:8384
        tls internal
      '';
    };
  };
  services.syncthing = {
    group = "users";
    guiAddress = "0.0.0.0:8384";
    enable = true;

    settings = {
      devices = {
        "laptop" = {
          id = "UC3MILQ-MXWD6R2-IW7AFWU-OY4PKOI-O7FFFCS-TBILQWP-SN3NJPK-P3U7PAP";
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
