{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay";

  inputs.home-manager.url = "github:nix-community/home-manager/release-22.05";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.painted = {
    url = "github:lincolnauster/painted/dev";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, emacs-overlay, home-manager, painted }:
    let commonModules = [
      home-manager.nixosModule
      ./homes.nix ./common.nix

      { nixpkgs.overlays = [ emacs-overlay.overlay ]; }

      ({config, ...}: {
        environment.systemPackages = [
          painted.defaultPackage.x86_64-linux
        ];
      })
    ]; in {
      defaultPackage.x86_64-linux =
        self.nixosConfigurations.iso.config.system.build.isoImage;

      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++
          [ "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            ./envs/gnome.nix];
      };

      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules
          ++ [ ./desktop.nix ./envs/gnome.nix ];
      };

    };
}
