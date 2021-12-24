# WSL2 on PC

{ config, pkgs, ... }:

{
  imports = [ ./common.nix ./genericLinux.nix ];

  home = {
    username = "james";
    homeDirectory = "/home/james";
  };
}
