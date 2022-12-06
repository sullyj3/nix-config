# Archlabs on laptop

{ config, pkgs, ... }:

{
  imports = [ ./common.nix ./genericLinux.nix ./guiLinux.nix ];

  home = {
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
    };
    packages = with pkgs; [
      # doesn't seem to work on WSL, leave it here for now
      # copilot doesn't support node 18 as of december 2022
      nodejs-16_x
    ];
  };
}
