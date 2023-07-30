# for linux systems with a gui (ie, no WSL)

{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      NEOVIDE_MULTIGRID = "true";
    };

    shellAliases = {
      win = "alacritty --working-directory . &; disown";
      nv = "neovide";
    };
  };

}
