{
  config,
  pkgs,
  lib,
  ...
}: {
  theme.lazydocker.enable = true;

  programs = {
    lazydocker = {
      enable = true;
    };
  };
}
