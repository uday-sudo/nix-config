{
  pkgs,
  config,
  ...
}: let
  domain = config.homebox.domain;
in {
  virtualisation = {
    containers = {
      containersConf.settings.network.dns_bind_port = 5353;
      registries = {
        search = [
          "git.${domain}"
          "docker.io"
          "mirror.gcr.io"
          "ghcr.io"
          "quay.io"
        ];
      };
    };
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
