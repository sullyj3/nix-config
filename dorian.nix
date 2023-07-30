# Archlabs on laptop

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ./genericLinux.nix ./guiLinux.nix ];

  home = {
    sessionVariables = {
      BROWSER = "google-chrome-stable";
    };
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
      feh = "feh --draw-filename --force-aliasing --auto-zoom --sort filename --version-sort";
    };
    packages = with pkgs; [
      # doesn't seem to work on WSL, leave it here for now
      nodejs_20
      signal-desktop
    ];
  };
}
