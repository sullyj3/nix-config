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
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, unison, neovim-nightly-overlay }:
    let
      username = "james";
      mkHomeConfig = { username, system, imports }: home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = imports ++ [ 
            ({
              nixpkgs.overlays = [ unison.overlay neovim-nightly-overlay.overlay ];
              home = {
                inherit username;
                stateVersion = "22.11";
                # TODO this would be wrong on a Mac
                homeDirectory = "/home/${username}";
              };
            })
          ];
        };

    in {
      homeConfigurations = {
        # Archlabs on laptop
        dorian = mkHomeConfig { 
          inherit username;
          system = "x86_64-linux";
          imports = [ ./dorian.nix ]; 
        };
        # WSL2 on PC
        mixolydian = mkHomeConfig { 
          inherit username; 
          system = "x86_64-linux";
          imports = [ ./common.nix ./genericLinux.nix ]; 
        };
      };
  };
}
