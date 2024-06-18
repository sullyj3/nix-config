# NixOS desktop

{ config, pkgs, ... }:

let
  myLib = import ./myLib.nix { inherit config; };
in
{
  imports = [
    ./basics.nix
    ./home.nix
    ./guiLinux.nix
  ];

  home.shellAliases = {
    nr = "nixos-rebuild";
  };

  xdg.configFile = {
    systemd = {
      source = (myLib.homeConfigLocation + "/xdg-config/systemd");
      recursive = true;
    };
  };
}
