{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";

  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay";

  inputs.home-manager.url = "github:nix-community/home-manager";

  inputs.amp = {
    url = "github:lincolnauster/amp/all";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.painted = {
    url = "github:lincolnauster/painted/dev";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, emacs-overlay, home-manager, amp, painted }:
    let commonModules = [
      home-manager.nixosModule
      ./homes.nix ./common.nix

      { nixpkgs.overlays = [ emacs-overlay.overlay ]; }

      ({config, ...}: {
        environment.systemPackages = [
          amp.defaultPackage.x86_64-linux
          painted.defaultPackage.x86_64-linux
        ];
      })
    ]; in {

      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules
          ++ [ ./desktop.nix ];
      };

    };
}
