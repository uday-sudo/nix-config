{
	outputs,
	pkgs,
	...
}: {
	imports = [
		../common/global
		../common/optional/de.nix
		../common/optional/fonts.nix
		../common/optional/quietboot.nix
		../common/users/uday

		./battery.nix
		./asusctl.nix
		./bluetooth.nix
		./cpu.nix
		./gpu.nix
		./dev.nix
		./disks.nix
		./gui.nix
		./filesystem.nix
		./network.nix
		./services.nix
	];

	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [];
	};
	system.stateVersion = "23.11";
}
