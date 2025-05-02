{ nixpkgs, nixos-stable, home-manager, ... }@inputs:
let
  overlays = with inputs; [ ];

  mkLinuxHomeConfig =
    { imports, which-nixpkgs }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = which-nixpkgs.legacyPackages."x86_64-linux";
      modules = imports ++ [
        ./basics.nix
        ({
          nixpkgs.overlays = overlays;

          # pin nixpkgs to version we're using for this configuration
          # in user registry (~/.config/nix/registry.json)
          # I think this allows us not to have to download the nixpkgs flake every 
          # time we run eg `nix shell nixpkgs#whatever`
          nix.registry.nixpkgs.flake = which-nixpkgs;
        })
      ];
      extraSpecialArgs = { };
    };
in
{
  basics = mkLinuxHomeConfig { imports = [ ]; };

  # Archlabs on laptop
  "james@dorian" = mkLinuxHomeConfig {
    imports = [ ./dorian.nix ];
    which-nixpkgs = nixpkgs;
  };
  
  # WSL2 on PC
  "james@Mixolydian" = mkLinuxHomeConfig {
    imports = [
      ./home.nix
      ./genericLinux.nix
    ];
    which-nixpkgs = nixos-stable;
  };

  # NixOS test vm
  "james@semibreve" = mkLinuxHomeConfig { 
    imports = [ ./semibreve.nix ];
    which-nixpkgs = nixos-stable;
  };

  # Raspberry Pi
  "james@locrian" = mkLinuxHomeConfig { 
    imports = [ ./locrian.nix ];
    which-nixpkgs = nixos-stable;
  };

  # NixOS desktop
  "james@phrygian" = mkLinuxHomeConfig { 
    imports = [ ./phrygian.nix ]; 
    
    # TODO upgrade
    which-nixpkgs = nixos-stable;
  };
}
