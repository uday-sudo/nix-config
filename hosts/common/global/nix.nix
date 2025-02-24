{ inputs, lib, pkgs, ... }:
{
  nix = {
		settings = {
			accept-flake-config = true;
			allowed-users = [ "root" "@wheel" ];
			auto-optimise-store = lib.mkDefault true;
			# Enable flakes and new 'nix' command
			experimental-features = "nix-command flakes";
			min-free = lib.mkDefault 1073741824;
			max-free = lib.mkDefault 1073741824;
		};

		# gc = {
		# 	automatic = lib.mkDefault true;
		# 	dates = lib.mkDefault "weekly";
		# 	options = lib.mkDefault "--delete-older-than 1m";
		# };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };
}
