# for linux systems with a gui (ie, no WSL)

{ config, pkgs, ... }:

{
  home = {
    sessionVariables.BROWSER = "google-chrome-stable";
    packages = with pkgs; [
      signal-desktop
    ];
    shellAliases = {
      win = "alacritty --working-directory . &; disown";
      feh = "feh --draw-filename --force-aliasing --auto-zoom --sort filename --version-sort";
    };
  };

}
