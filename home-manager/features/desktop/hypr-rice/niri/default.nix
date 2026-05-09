{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  windowRules = import ./window-rules.nix {inherit inputs;};
  c = config.theme.colors;
  inherit (inputs.niri.lib.kdl) leaf plain;
  recentWindowsRaw = [
    (plain "recent-windows" [
      (leaf "open-delay-ms" 120)
      (leaf "debounce-ms" 400)
      (plain "highlight" [
        (leaf "active-color" "${c.base0D}cc")
        (leaf "urgent-color" "${c.base08}cc")
        (leaf "padding" 20)
        (leaf "corner-radius" 12)
      ])
      (plain "previews" [
        (leaf "max-height" 540)
        (leaf "max-scale" 0.6)
      ])
    ])
  ];

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
    ./settings.nix
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.config =
    niriSettings.render config.programs.niri.settings
    ++ windowRules.raw
    ++ recentWindowsRaw;
}
