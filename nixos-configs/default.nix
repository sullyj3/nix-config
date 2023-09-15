{ nixpkgs }:
{
  semibreve = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ./semibreve/configuration.nix ];
  };

  locrian = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ./locrian/configuration.nix ];
  };
}
