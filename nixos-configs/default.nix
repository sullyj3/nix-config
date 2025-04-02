{
  nixpkgs,
  nixos-24-05,
  niri-flake,
  ...
}@inputs:
{
  semibreve = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ./semibreve/configuration.nix ];
  };

  # build with:
  # nix build .#nixosConfigurations.live.config.system.build.isoImage
  live = nixos-24-05.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      (nixos-24-05 + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix")
      ./live/configuration.nix
    ];
  };

  phrygian = nixos-24-05.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./phrygian/configuration.nix
      niri-flake.nixosModules.niri
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
