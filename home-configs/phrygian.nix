# NixOS desktop

{ config, pkgs, ... }:

let
  myLib = import ./myLib.nix { inherit config; };
  packageOverrides = import ./packageOverrides { inherit pkgs; };
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
    pkgs.nerd-fonts.fira-code
    pkgs.font-awesome
    pkgs.mononoki
    # packageOverrides.godot4-3-beta2
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
  fonts.fontconfig.enable = true;

  xdg.configFile = {
    systemd = {
      source = (myLib.homeConfigLocation + "/xdg-config/systemd");
      recursive = true;
    };
  };

  programs.waybar.enable = true;
  programs.firefox.enable = true;
}
