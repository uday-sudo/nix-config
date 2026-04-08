{
  outputs,
  pkgs,
  lib,
  config,
  ...
}: {
  sops.secrets."host_password/homebox".neededForUsers = true;

  imports = [
    ../common/global
    ../server

    ../common/users/hooman

    ./bluetooth.nix
    ./cpu.nix
    ./dev.nix
    ./disks.nix
    ./filesystem.nix
    ./network.nix
    ./hardware-configuration.nix
  ];

  users.users.root.hashedPasswordFile = config.sops.secrets."host_password/homebox".path;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ8yGpF8gsJNiJy6rWB5b1ZFS8xKQcPhxB3iW9Te7CKP uday@breadboard"
  ];

  users.users.hooman.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ8yGpF8gsJNiJy6rWB5b1ZFS8xKQcPhxB3iW9Te7CKP uday@breadboard"
  ];

  environment.enableAllTerminfo = true;
  programs.nh.flake = "${config.users.users.hooman.home}/gitjargan/nix-config";

  systemd.services.postgres-daily-backup = lib.mkIf config.services.postgresql.enable {
    description = "Daily PostgreSQL backup for homebox";
    after = ["postgresql.service"];
    wants = ["postgresql.service"];
    path = [
      config.services.postgresql.package
      pkgs.coreutils
      pkgs.zip
      pkgs.gnugrep
      pkgs.gawk
    ];
    serviceConfig = {
      Type = "oneshot";
      User = "postgres";
      Group = "postgres";
    };
    script = ''
      set -euo pipefail

      backup_dir="/run/media/hdd/backups/postgres"
      timestamp="$(date +%F-%H%M%S)"
      host_name="${config.networking.hostName}"
      tmpdir="$(mktemp -d)"
      sql_dump="$tmpdir/$host_name-$timestamp.sql"
      zip_path="$backup_dir/$host_name-$timestamp.zip"

      mkdir -p "$backup_dir"
      trap 'rm -rf "$tmpdir"' EXIT

      pg_dumpall > "$sql_dump"
      zip -j "$zip_path" "$sql_dump"
    '';
  };

  systemd.timers.postgres-daily-backup = lib.mkIf config.services.postgresql.enable {
    description = "Daily PostgreSQL backup timer for homebox";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "15m";
    };
  };

  system.stateVersion = "26.05";
}
