# for linux systems with a gui (ie, no WSL)

{ config, pkgs, ... }:

let
  myLib = import ./myLib.nix { inherit config; };
in
{
  home = {
    sessionVariables = {
      TERMINAL = "wezterm";
    };

    shellAliases = {
      win = "open-wezterm-here";
    };
    packages =  [
      pkgs.swww # wayland wallpaper daemon
    ];

  };

  xdg.configFile = {
    # "i3/config".source = myLib.link (myLib.xdgConf + "/i3/config");
    # black system tray bug is fixed in unreleased PR 
    # Issue: polybar/polybar/issues/1995
    # PR: polybar/polybar/pull/2609 (merged)
    # to be released in v3.7.0

    # "polybar" = {
    #   source = myLib.xdgConf + "/polybar";
    #   recursive = true;
    # };

    niri.source = myLib.link (myLib.homeConfigLocation + "/xdg-config/niri");
    waybar.source = myLib.link (myLib.homeConfigLocation + "/xdg-config/waybar");
    wezterm.source = myLib.link (myLib.homeConfigLocation + "/xdg-config/wezterm");
  };
}
