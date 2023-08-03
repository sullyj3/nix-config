{ nixpkgs, home-manager, ... }@inputs:
let
  overlays = with inputs; [ 
    yyp.overlays.default
    jj.overlays.default
  ];

  mkLinuxHomeConfig = { imports }: home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit nixpkgs; };
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    modules = imports ++ [ 
      ./basics.nix
      ({ nixpkgs.overlays = overlays; })
    ];
  };
in
{
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
}
