{ config, ... }:
{
  # Hard coding this path is not ideal. Revisit if a better solution is found.
  homeConfigLocation = config.home.homeDirectory + "/nix-config/home-configs";
  xdgConf = ./xdg-config;
  dotfiles = ./dotfiles;
}
