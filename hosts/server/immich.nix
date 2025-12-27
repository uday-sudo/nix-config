{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  domain = config.homebox.domain;
  svcName = "immich";
  port = 9833;
in {
  services.caddy = {
    virtualHosts."${svcName}.${domain}" = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString port}
        request_body {
            max_size 1000MB
        }
        tls internal
      '';
    };
  };
  services.immich = {
    port = port;
    enable = true;
  };
}
