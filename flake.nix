{
  description = "Nix configuration of James Sully";

  inputs = {
    nixos-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-24.11";
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

  outputs =
    {
      self,
      nixos-24-05,
      nixos-stable,
      nixpkgs,
      systems,
      home-manager,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      nixosConfigurations = import ./nixos-configs { inherit nixpkgs nixos-24-05 nixos-stable; };
      homeConfigurations = import ./home-configs inputs;
      devShells = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell { buildInputs = [ pkgs.nixfmt-rfc-style ]; };
        }
      );
    };
}
