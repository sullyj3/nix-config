{
  description = "Home Manager configuration of James Sully";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    unison.url = "github:ceedubs/unison-nix";
  };

  outputs = { self, nixpkgs, home-manager, unison }:
    let
      system = "x86_64-linux";
      username = "james";
    in {
      homeConfigurations.dorian = home-manager.lib.homeManagerConfiguration {
        configuration = {
          imports = [ ./dorian.nix ];
          nixpkgs.overlays = [ unison.overlay ];
        };

        inherit system username;
        homeDirectory = "/home/${username}";
        stateVersion = "22.05";

      };
    };
}
