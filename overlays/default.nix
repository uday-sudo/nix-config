# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {
    pkgs = final;
    inputs = inputs; # this 'inputs' must be visible in this scope!
  };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    catppuccin-kde = prev.catppuccin-kde.overrideAttrs (oldAttrs: {
      postInstall = ''
        ${oldAttrs.postInstall or ""}  # Preserve existing postInstall steps

        # Patch the CatppuccinMocha-Modernrc file
        file="$out/share/aurorae/themes/CatppuccinMocha-Modern/CatppuccinMocha-Modernrc"
        echo $file
        if [[ -f "$file" ]]; then
          sed -i 's/TitleHeight=26/TitleHeight=26/' "$file"
          sed -i 's/ButtonHeight=37/ButtonHeight=24/' "$file"
          sed -i 's/ButtonWidth=37/ButtonWidth=24/' "$file"
        else
          echo "Error: File $file not found!"
          exit 1
        fi
      '';
    });

    discord = prev.discord.override {
      withVencord = true;
    };

    lutris = prev.lutris.override {
      extraPkgs = pkgs: [
        pkgs.wineWowPackages.stagingFull
        pkgs.winetricks
      ];
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
