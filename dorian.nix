{ config, pkgs, ... }:

{
  home = {
    username = "james";
    homeDirectory = "/home/james";
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      # Todo: this alias isn't being set for some reason
      # investigate how `imports` (above) works
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
    };
  };
}
