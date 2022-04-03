{ config, pkgs, ... }:

{
  imports = [ ./common.nix ./genericLinux.nix ./guiLinux.nix ];

  home = {
    username = "james";
    homeDirectory = "/home/james";
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
    };
  };
}
