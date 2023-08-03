# for linux systems with a gui (ie, no WSL)

{ config, pkgs, ... }:
  # todo figure out how to extract this stuff into a module
let
  link = config.lib.file.mkOutOfStoreSymlink;
  homeDirectory = config.home.homeDirectory;
  # Hard coding this path is not ideal. Revisit if a better solution is found.
  homeConfigLocation = "${homeDirectory}/nix-config/home-configs";
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
    "i3/config".source = link "${homeConfigLocation}/config/i3/config";
    "polybar" = {
      source = ./config/polybar;
      recursive = true;
    };
  };
}
