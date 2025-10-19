{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  services.caddy = {
    virtualHosts.${cfg.settings.server.DOMAIN} = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString srv.HTTP_PORT}
        request_body {
            max_size 512MB
        }
        tls internal
      '';
    };
  };

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    settings = {
      session.COOKIE_SECURE = true;
      DEFAULT = {
        APP_NAME = "Uday's Software forge";
        APP_SLOGAN = "To Code and beyond";
      };
      server = {
        DOMAIN = "git.homebox.com";
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = 3000;
      };
      service.DISABLE_REGISTRATION = false;
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
        ARTIFACT_RETENTION_DAYS = 30;
      };
    };
    dump = {
      enable = true;
      backupDir = "/run/media/hdd/forgejo";
      interval = "22:00";
      type = "tar.zst";
    };
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "monolith";
      url = "http://localhost:${toString srv.HTTP_PORT}";
      # Obtaining the path to the runner token file may differ
      # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
      tokenFile = "/var/lib/forgejo/token";
      labels = [
        "ubuntu-22.04:docker://ubuntu:22.04"
        "nixos-nix-flake:docker://git.homebox.com/uday-sudo/nix-flake-container:latest"
        "docker:docker://docker:latest"
        "podman:docker://podman:latest"
        ## optionally provide native execution on the host:
        "native:host"
      ];
      settings = {
        runner = {
          insecure = true;
        };
      };
      hostPackages = with pkgs; [
        bash
        coreutils
        curl
        gawk
        gitMinimal
        openssh
        nodejs
        gnused
        wget
        alejandra

        # Nix tooling
        # nix
        # nix-prefetch-git
        # nixfmt-rfc-style # or alejandra for formatting
        alejandra
        cacert # required for HTTPS with nix
        gitFull
        # nixVersions.stable
      ];
    };
  };
  sops.secrets.forgejo-admin-password.owner = "forgejo";
  systemd.services.forgejo.preStart = let
    adminCmd = "${lib.getExe cfg.package} admin user";
    pwd = config.sops.secrets.forgejo-admin-password;
    user = "admin";
  in ''
    ${adminCmd} create --admin --email "root@localhost" --username ${user} --password "12345678" || true
    ${adminCmd} create --email "udayavenegerdude@gmail.com" --username uday-sudo --password "12345678" || true
    ## uncomment this line to change an admin user which was already created
    # ${adminCmd} change-password --username ${user} --password "$(tr -d '\n' < ${pwd.path})" || true
  '';
}
