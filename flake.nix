{
  description = "Gordon's Cfg";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
	inherit (self) outputs;
	  in {
	nixosConfigurations = {
		nixos = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs outputs;};
			modules = [./configuration.nix];
		};
	};



    homeConfigurations = {
	myprofile = home-manager.lib.homeManagerConfigurations {
		pkgs = nixpkgs.legacyPackages.x86_64-linux;
		extraSpecialArgs = {inherit inputs outputs;};
		modules = [./home.nix];
	};
    };
};
}
