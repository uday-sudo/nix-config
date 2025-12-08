{
  description = "NixOS Config for uday-sudo";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    grub2-themes,
    disko,
    deploy-rs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (
      system:
        import ./pkgs {
          inherit (nixpkgs) legacyPackages;
          pkgs = nixpkgs.legacyPackages.${system};
          inherit inputs;
        }
    );
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      breadboard = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/breadboard
          grub2-themes.nixosModules.default
        ];
      };

      homebox = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules =
          [
            ./hosts/homebox
          ]
          ++ (builtins.attrValues disko.nixosModules);
      };
    };

    deploy = {
      nodes.homebox = {
        hostname = "homebox";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.homebox;
        };
      };
      remoteBuild = true;
    };

    # This is highly advised, and will prevent many possible mistakes
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "uday@breadboard" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules =
          [
            ./home-manager/uday/home.nix
          ]
          ++ (builtins.attrValues outputs.homeManagerModules);
      };

      "hooman@homebox" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules =
          [
            ./home-manager/hooman/home.nix
          ]
          ++ (builtins.attrValues outputs.homeManagerModules);
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # For some important hardware utilities for my Asus Laptops
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes.url = "github:vinceliuice/grub2-themes";

    mysecrets = {
      url = "git+ssh://git@github.com/uday-sudo/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

    nur = {
      url = "github:nix-community/nur?shallow=1";
    };

    # Shimmer theme
    firefox-theme = {
      url = "github:nuclearcodecat/shimmer?ref=main&shallow=1";
      flake = false;
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    wallpapers = {
      url = "git+ssh://git@github.com/uday-sudo/wallpapers.git?shallow=1&lfs=1&ref=main";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };
  };
}
