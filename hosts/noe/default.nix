{
  inputs,
  ...
}:
with inputs;
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./configuration.nix
      #
      # home-manager.nixosModules.home-manager
      #
      # {
      #   home-manager = {
      #     useGlobalPkgs = true;
      #     useUserPackages = true;
      #     extraSpecialArgs = {
      #       inherit inputs;
      #     };
      #     users = {
      #       gordo = import ../../modules/home/gordo.nix;
      #     };
      #   };
      # }
    ];
  }
