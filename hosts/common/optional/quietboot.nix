{
	config,
	pkgs,
	...
}: {

	boot = {
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "nvme" "usbhid" ];
			kernelModules = [ ];
		};
		kernelModules = [ "kvm-amd" ];
		#Silent Boot
		kernelParams = [
			"quiet"
			"splash"
			"udev.log_level=3"
		];
		kernelPackages = pkgs.linuxPackages_latest;
		consoleLogLevel = 3;
		initrd.verbose = false;
	};
}
