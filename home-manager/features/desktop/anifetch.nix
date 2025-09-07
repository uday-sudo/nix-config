# packages.nix or any other module file
{
  config,
  pkgs,
  anifetch,
  ...
}: {
  home.packages = [
    anifetch.packages.x86_64-linux.default
    # other packages...
  ];
}
