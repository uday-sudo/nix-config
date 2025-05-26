{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53; # Port for incoming DNS Queries.
      upstreams.groups.default = [
        "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];
      # For initially solving DoH/DoT Requests when no system Resolver is available.
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = ["1.1.1.1" "1.0.0.1" "8.8.8.8"];
      };
      #Enable Blocking of certian domains.
      blocking = {
        blackLists = {
          #Adblocking
          ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"];
          # adult = ["https://blocklistproject.github.io/Lists/porn.txt"];
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = ["ads"];
          # kids-ipad = ["ads" "adult"];
        };
      };
      customDNS = {
        mapping = {
          "homebox.com" = "192.168.0.169";
          "*.homebox.com" = "192.168.0.169";
        };
        customTTL = "2h";
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
    };
  };
}
