{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.caddy = {
    virtualHosts."immich.homebox.com" = {
      extraConfig = ''
        reverse_proxy http://localhost:9833
        request_body {
            max_size 1000MB
        }
        tls internal
      '';
    };
  };
  services.immich = {
    port = 9833;
    enable = true;
  };
}
