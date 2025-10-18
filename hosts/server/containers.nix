{pkgs, ...}: {
  virtualisation = {
    # oci-containers.containers = {
    #   jitsi-try = {
    #     image = "jitsi/web";
    #     ports = ["8090:7689"];
    #     extraOptions = [
    #       "--pull=always"
    #     ];
    #   };
    # };
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

  # environment.variables.DOCKER_HOST = "unix://${XDG_RUNTIME_DIR}/podman/podman.sock";

  users.users.hooman = {
    extraGroups = ["podman"];
  };
}
