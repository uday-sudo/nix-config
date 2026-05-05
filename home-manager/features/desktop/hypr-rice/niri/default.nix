{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  windowRules = import ./window-rules.nix {inherit inputs;};

  # niri-flake has not exposed background-effect in typed settings yet,
  # so render the merged settings and append the missing raw KDL rule.
  niriSettings = import "${inputs.niri.outPath}/settings.nix" {
    inputs = {
      self = {};
      niri-stable = pkgs.niri-stable.src;
      niri-unstable = pkgs.niri-unstable.src;
    };
    kdl = inputs.niri.lib.kdl;
    inherit lib;
    docs = {};
    binds = _: [];
    settings = {};
  };
in {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    inputs.dms.homeModules.niri
    ./settings.nix
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.config =
    niriSettings.render config.programs.niri.settings
    ++ windowRules.raw;
}
