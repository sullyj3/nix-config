{
  description = "Nix configuration of James Sully";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      mkLinuxHomeConfig = { imports }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = imports ++ [ 
          ({
            nixpkgs.overlays = [ ];
            home = 
              let 
                username = "james";
              in
              {
                username = username;
                stateVersion = "23.11";
                homeDirectory = "/home/${username}";
              };
          })
        ];
      };

    in {
      nixosConfigurations.semibreve = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./semibreve/configuration.nix ];
      };

      homeConfigurations = {
        # Archlabs on laptop
        "james@dorian" = mkLinuxHomeConfig { 
          imports = [ ./dorian.nix ]; 
        };
        # WSL2 on PC
        "james@mixolydian" = mkLinuxHomeConfig { 
          imports = [ ./home.nix ./genericLinux.nix ]; 
        };

        # NixOS test vm
        "james@semibreve" = mkLinuxHomeConfig {
          imports = [ ./semibreve.nix ];
        };

        basics = mkLinuxHomeConfig {
          imports = [ ./basics.nix ];
        };
      };
    };
}
