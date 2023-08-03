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
      TERMINAL = "alacritty";
    };

    shellAliases = {
      win = "alacritty --working-directory . &; disown";
      nv = "neovide";
    };
  };

  xdg.configFile = {
    "i3/config".source = myLib.link "${myLib.homeConfigLocation}/config/i3/config";
    "polybar" = {
      source = ./config/polybar;
      recursive = true;
    };
  };
}
