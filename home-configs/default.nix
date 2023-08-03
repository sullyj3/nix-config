{ mkLinuxHomeConfig }:
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
