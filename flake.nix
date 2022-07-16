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
      mkHomeConfig = { username, imports }: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = imports ++ [ 
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

    in {
      homeConfigurations = {
        # Archlabs on laptop
        dorian = mkHomeConfig { 
          inherit username; imports = [ ./dorian.nix ]; 
        };
        # WSL2 on PC
        mixolydian = mkHomeConfig { 
          inherit username; 
          imports = [ ./common.nix ./genericLinux.nix ]; 
        };
    };
  };
}
