{
  description = "Nix configuration of James Sully";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yyp = {
      url = "github:sullyj3/yyp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, systems, home-manager, ... }@inputs:
  let 
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in {
      nixosConfigurations = import ./nixos-configs { inherit nixpkgs; };
      homeConfigurations = import ./home-configs inputs;
      devShells = forEachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in { default = pkgs.mkShell { buildInputs = [ pkgs.nixfmt ]; }; });
    };
}
