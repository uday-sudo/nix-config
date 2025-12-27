{
  config,
  lib,
  ...
}: {
  options.homebox = {
    domain = lib.mkOption {
      type = lib.types.str;
      default = "homebox.com";
      description = "Domain used for services on this host (e.g. homebox.com).";
    };
  };
}
