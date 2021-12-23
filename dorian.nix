{ config, pkgs, ... }:

{
  imports = [ ./common.nix ./genericLinux.nix ./guiLinux.nix ];

  home = {
    username = "james";
    homeDirectory = "/home/james";
  };
}
