{config, lib, pkgs, ...}:
{
  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        "server" = {
          id = "3DDSIAR-OO4H7PG-HQO6HEC-WGWJRLF-XCHTS6M-3Y3NP6N-RFZFYBB-3HNQQA6";
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