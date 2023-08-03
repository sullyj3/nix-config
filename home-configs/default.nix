{ nixpkgs, home-manager, ... }@inputs:
let
  mkLinuxHomeConfig = { imports }: home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit nixpkgs; };
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    modules = imports ++ [ 
      ({
        nixpkgs.overlays = with inputs; [ 
          yyp.overlays.default
          jj.overlays.default
        ];
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
