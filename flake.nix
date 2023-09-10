{
  description = "Nix configuration of James Sully";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
    {
      nixosConfigurations = import ./nixos-configs { inherit nixpkgs; };
      homeConfigurations = import ./home-configs inputs;
    };
}
