# for linux systems with a gui (ie, no WSL)

{ config, pkgs, ... }:
# todo figure out how to extract this stuff into a module
let
  myLib = import ./myLib.nix { inherit config; };
in
{
  home = {
    sessionVariables = {
      NEOVIDE_MULTIGRID = "true";
      TERMINAL = "wezterm";
    };

    shellAliases = {
      # win = "alacritty --working-directory . &; disown";
      win = "wezterm start --cwd=.";
      nv = "neovide";
    };
  };

  home.file.".xprofile".source = myLib.link (myLib.dotfiles + "/xprofile");

  xdg.configFile = {
    "i3/config".source = myLib.link (myLib.xdgConf + "/i3/config");
    # black system tray bug is fixed in unreleased PR 
    # Issue: polybar/polybar/issues/1995
    # PR: polybar/polybar/pull/2609 (merged)
    # to be released in v3.7.0

    # "polybar" = {
    #   source = myLib.xdgConf + "/polybar";
    #   recursive = true;
    # };

    "niri/config.kdl".source = myLib.link (myLib.homeConfigLocation + "/xdg-config/niri/config.kdl");
  };
}
