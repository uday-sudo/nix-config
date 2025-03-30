{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./syncthing.nix
    ./filebrowser.nix
    ./torrent.nix
    ./forgejo.nix
    ./containers.nix
    ./video.nix
    ./dns.nix
    inputs.sops-nix.nixosModules.sops
  ];

  sops.secrets = {
    "nginx/SSL-key" = {
      owner = "nginx";
      group = "nginx";
    };
    "nginx/SSL-cert" = {
      owner = "nginx";
      group = "nginx";
      mode = "0444";
    };
  };
  services.nginx.enable = true;
}
