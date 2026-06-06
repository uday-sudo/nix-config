{
  inputs,
  outputs,
  lib,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    ../features/core
    ../features/productivity/neovim
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.nur.overlays.default

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "uday";
    homeDirectory = "/home/uday";

    shellAliases = lib.mkForce {
      reborn = "reboot";
      die = "shutdown -P now";
      pls = "sudo";
      icat = "kitten icat";
    };
    sessionVariables = lib.mkForce {
      TERMINAL = "ghostty";
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";

  #colorscheme module
  theme.enable = true;
  theme.oh-my-posh = {
    enable = true;
    configFile = "emodipt-extend";
  };

}
