{
  description = "Dotfiles: RANK1ZEN";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    # Used with `nixos-rebuild switch --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    nixosConfigurations = {
      noe = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [./hosts/noe/configuration.nix];
      };
    };

    # Used with `home-manager switch --flake .#<username>`
    homeConfigurations = {
      n0 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/home/base.nix
          ({pkgs, ...}: {
            nix.package = pkgs.nix;
            nix.settings = {
              experimental-features = [
                "nix-command"
                "flakes"
              ];
            };
          })
        ];
      };
      n1 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./modules/home/base.nix
          ./modules/home/desktop.nix
          ({
            pkgs,
            lib,
            ...
          }: {
            nix.package = pkgs.nix;
            home = {
              username = "gordo";
              homeDirectory = "/home/gordo";
              activation = {
                linkMyStuff = lib.hm.dag.entryAfter ["writeBoundary"] ''
                  ln -sf -t $HOME/nix-cfg/hypr
                '';
              };
              packages = with pkgs; [
                # hyprland things
                slurp
                grim
                fuzzel
                wl-clipboard

                hyprland
              ];
            };
          })
        ];
      };
    };
  };
}
