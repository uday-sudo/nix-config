# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
  pkgs,
  inputs,
  ...
}: {
  # example = pkgs.callPackage ./example { };
  # olivetin = pkgs.callPackage ./olivetin.nix { };
  sddm-theme-corners = pkgs.callPackage ./sddm-theme.nix {
    wallpapers = inputs.wallpapers;
  };
}
