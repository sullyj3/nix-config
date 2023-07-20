{
  description = "Home Manager configuration of James Sully";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
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
                stateVersion = "22.11";
                homeDirectory = "/home/${username}";
              };
          })
        ];
      };

    in {
      homeConfigurations = {
        # Archlabs on laptop
        dorian = mkLinuxHomeConfig { 
          imports = [ ./dorian.nix ]; 
        };
        # WSL2 on PC
        mixolydian = mkLinuxHomeConfig { 
          imports = [ ./common.nix ./genericLinux.nix ]; 
        };
      };
  };
}
