{
  description = "Home Manager configuration of James Sully";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    unison.url = "github:ceedubs/unison-nix";
  };

  outputs = { self, nixpkgs, home-manager, unison }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "james";
    in {
      homeConfigurations.dorian = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ 
          ./dorian.nix
          ({
            nixpkgs.overlays = [ unison.overlay ];
            home = {
              inherit username;
              stateVersion = "22.11";
              homeDirectory = "/home/${username}";
            };
          })
        ];


      };
    };
}
