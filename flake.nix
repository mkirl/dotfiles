{

  description = "KirlOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
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
      theLocale = "en_US.UTF-8";
      gitUsername = "Michael Kirl";
      wallpaperDir = "/home/${username}/Pictures/Wallpapers";
      wallpaperGit = "https://github.com/mkirl/wallpaper-collection.git";
      browser = "firefox";
      borderAnim = "on";
      waybarStyle = "style2";
      flakeDir = "/home/${username}/.dotfiles";      
      gitEmail = "michael.e.kirl@gmail.com";
      theme = "gigavolt";
      intel-bus-id = "PCI:0:2:0";

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
          inherit theTimezone; inherit wallpaperGit;
	  inherit wallpaperDir; inherit gitUsername;
	  inherit theLocale;
	}; 
        modules = [ ./system.nix 
	  home-manager.nixosModules.home-manager {
	    home-manager.extraSpecialArgs = {
	      inherit username; inherit gitUsername;
	      inherit inputs; inherit flakeDir;
	      inherit wallpaperGit; inherit borderAnim;
              inherit gpuType; inherit cpuType;
              inherit browser; inherit wallpaperDir;
              inherit gitEmail; 
              inherit waybarStyle;
              inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemefromSchema;

	    };
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.${username} = import ./home.nix;
	  }
	];
     };
    };
  };
}
