{ config, ... }:
rec {
  homeConfigLocation = config.home.homeDirectory + "/nix-config/home-configs";
  xdgConf = homeConfigLocation + "/xdg-config";
  dotfiles = homeConfigLocation + "/dotfiles";
}
