{
	inputs,
	lib,
	pkgs,
	config,
	...
}: {
	boot.loader = {
		grub = {
			enable = lib.mkDefault true;
			efiSupport = lib.mkDefault true;
			device = lib.mkDefault "nodev";
			useOSProber = lib.mkDefault true;
			copyKernels = lib.mkDefault false;
		};
		efi.canTouchEfiVariables = lib.mkDefault true;
		efi.efiSysMountPoint = lib.mkDefault "/boot/efi";
    };


	# GRUB THEME
    boot.loader.grub2-theme = {
		enable = true;
		theme = "vimix";
		footer = true;
		customResolution = "1920x1080";  # Optional: Set a custom resolution
	};
}
