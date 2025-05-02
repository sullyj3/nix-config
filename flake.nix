{
  description = "Nix configuration of James Sully";

  inputs = {
    nixos-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    niri-flake = {
      url = "github:sodiboo/niri-flake";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixos-stable";
    };
  };

  outputs =
    {
      self,
      nixos-24-05,
      nixpkgs,
      systems,
      home-manager,
      niri-flake,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      nixosConfigurations = import ./nixos-configs inputs;
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
