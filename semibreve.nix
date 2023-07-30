# Archlabs on laptop

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

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
    ];
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
