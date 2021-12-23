# for linux systems with a gui (ie, no WSL)

{ config, pkgs, ... }:

{
  home = {
    sessionVariables.BROWSER = "google-chrome-stable";
    packages = with pkgs; [
      signal-desktop
      google-chrome
    ];
  };

}
