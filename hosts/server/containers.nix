{pkgs, ...}: {
  virtualisation = {
    containers = {
      containersConf.settings.network.dns_bind_port = 5353;
      registries = {
        search = [
          "git.homebox.com"
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
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
