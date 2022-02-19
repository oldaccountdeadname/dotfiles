{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";

  inputs.home-manager.url = "github:nix-community/home-manager";

  inputs.amp = {
    url = "github:lincolnauster/amp/all";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.painted = {
    url = "github:lincolnauster/painted/dev";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, amp, painted }:
    let commonModules = [
      home-manager.nixosModule
      ./homes.nix ./common.nix

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
