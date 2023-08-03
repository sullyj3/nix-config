{
  description = "Nix configuration of James Sully";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yyp = {
      url = "github:sullyj3/yyp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jj = {
      url = "github:martinvonz/jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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

    in {
      nixosConfigurations = (import ./nixos-configs) { inherit nixpkgs; };
      homeConfigurations = (import ./home-configs) { inherit mkLinuxHomeConfig; };
    };
}
