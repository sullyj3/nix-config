# Archlabs on laptop

{ config, pkgs, ... }:

{
  imports = [ ./basics.nix ./home.nix ./guiLinux.nix ];
}
