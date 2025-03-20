{config, lib, pkgs, ...}:
{
  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        "server" = {
          id = "A6DW2IE-KN6I32O-MS33KRN-47DNDSA-OHWTGM6-RARNDY2-JETDPPQ-SW2TCQC";
        };
        "phone" = {
          id = "ZQWSMLR-YLJZIC7-RJGE2N4-V3BBW2P-NCSUFJ5-BYK7P32-4VCRBUZ-FFJ53A4";
        };
      };

      folders = {
        "keepass" = {
          path = "${config.home.homeDirectory}/SYNC/keepass";
          devices = [ "server" "phone" ];
        };

        "vault" = {
          path = "${config.home.homeDirectory}/SYNC/vault";
          devices = [ "server" "phone" ];
        };
      };

      gui = {
        user = "uday";
        password = "1234";
      };
    };
  };
}