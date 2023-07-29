# Archlabs on laptop

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  home = { 
    packages = [
      pkgs.xclip
    ];
  };

}
