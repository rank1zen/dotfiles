{
  lib,
  inputs,
  system,
  home-manager,
  user,
  ...
}: {
  noe = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit user inputs;};
    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user;};
        home-manager.users.${user} = import ./home.nix;
      }
    ];
  };
}
