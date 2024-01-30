{

  description = "KirlOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";

      # User Variables
      hostname = "nixos";
      username = "mike";
      cpuType = "intel";
      gpuType = "intel";
      theKBDLayout = "us";
      theLCVariables = "en_US.UTF-8";
      theTimezone = "America/Chicago";

      pkgs = import nixpkgs {
        inherit system;
      };

    in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
	  inherit system; inherit inputs;
	  inherit username; inherit hostname;
	  inherit cpuType; inherit theKBDLayout;
	  inherit theLCVariables; inherit gpuType;
          inherit theTimezone;
	}; 
        modules = [ ./system.nix ];
     };
    };
  };
}
