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
  home.packages = [
    pkgs.swaybg
    pkgs.waypaper
  ];

  home.pointerCursor = {
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor-Light";
    x11.enable = true;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Numix-Cursor-Light";
      package = pkgs.numix-cursor-theme;
    };
  };

  xdg.configFile = {
    systemd = {
      source = (myLib.homeConfigLocation + "/xdg-config/systemd");
      recursive = true;
    };
  };

  programs.waybar.enable = true;
}
