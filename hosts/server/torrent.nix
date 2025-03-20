{...}:
{
  services.qbittorrent = {
    enable = true;
    group = "users";
    port = 7044;
  };
  systemd.services.qbittorrent.wantedBy = lib.mkForce [];

}