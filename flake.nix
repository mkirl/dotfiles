{

  description = "KirlOS";
  inputs = {
    nixpkgs.url = "nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib; 
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configurations.nix ];
      }
    };
  };
}
