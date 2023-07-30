# Archlabs on laptop

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ./guiLinux.nix ];

  home = { 
    sessionVariables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
    };
    shellAliases = {
      win = "alacritty --working-directory . &; disown";
    };

    packages = [
      pkgs.xclip
      pkgs.file
      pkgs.alacritty
      (pkgs.polybar.override {
        i3Support = true;
      })
      pkgs.xfce.exo
      pkgs.xfce.xfce4-screenshooter
    ];
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
