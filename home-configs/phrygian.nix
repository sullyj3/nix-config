# NixOS desktop

{ config, pkgs, ... }:

let myLib = import ./myLib.nix { inherit config; };
in {
  imports = [ ./basics.nix ./home.nix ./guiLinux.nix ];

  xdg.configFile = {
    niri.source = myLib.link (myLib.homeConfigLocation + "/xdg-config/niri");
    waybar.source = myLib.link (myLib.homeConfigLocation + "/xdg-config/waybar");
    systemd = {
      source = (myLib.homeConfigLocation + "/xdg-config/systemd");
      recursive = true;
    };
  };
}
