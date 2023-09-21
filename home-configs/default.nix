{ nixpkgs, home-manager, ... }@inputs:
let
  overlays = with inputs; [ yyp.overlays.default jj.overlays.default ];

  mkLinuxHomeConfig = { imports }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = imports ++ [
        ./basics.nix
        ({
          nixpkgs.overlays = overlays;

          # pin nixpkgs to version we're using for this configuration
          # in user registry (~/.config/nix/registry.json)
          # I think this allows us not to have to download the nixpkgs flake every 
          # time we run eg `nix shell nixpkgs#whatever`
          nix.registry.nixpkgs.flake = nixpkgs;

        })
      ];
    };
in {
  basics = mkLinuxHomeConfig { imports = [ ]; };

  # Archlabs on laptop
  "james@dorian" = mkLinuxHomeConfig { imports = [ ./dorian.nix ]; };
  # WSL2 on PC
  "james@Mixolydian" =
    mkLinuxHomeConfig { imports = [ ./home.nix ./genericLinux.nix ]; };

  # NixOS test vm
  "james@semibreve" = mkLinuxHomeConfig { imports = [ ./semibreve.nix ]; };

  # Raspberry Pi
  "james@locrian" = mkLinuxHomeConfig { imports = [ ./locrian.nix ]; };
}
