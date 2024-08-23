{
  description = "Gordon's Cfg";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
  	system = "x86_64-linux";
	user = "gordo";

	pkgs = import nixpkgs {
		inherit system;
	};

	lib = nixpkgs.lib;
  in
  {
	# nixosConfigurations = {
	# 	gordo = nixpkgs.lib.nixosSystem {
	# 		system = "x86_64-linux";
	# 		modules = [
	# 			./configuration.nix
	# 			home-manager.nixosModules.home-manager
	# 			{
	# 				home-manager.useGlobalPkgs = true;
	# 				home-manager.useUserPackages = true;
	# 				home-manager.users.gordo = import ./home.nix;
	# 			}
	# 		];
	# 	};
	# };

	nixosConfigurations = (
		import ./hosts {
			inherit (nixpkgs) lib;
			inherit inputs user system home-manager;
		}
	);
};
}
