# Archlabs on laptop

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ./genericLinux.nix ./guiLinux.nix ];

  home = {
    sessionVariables = {
      BROWSER = "google-chrome-stable";
    };
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
      feh = "feh --draw-filename --force-aliasing --auto-zoom --sort filename --version-sort";

      # jujutsu
      js = "jj status";
      jl = "jj log";
    };
    packages = with pkgs; [
      # doesn't seem to work on WSL, leave it here for now
      nodejs_20
      signal-desktop
      litecli
    ];
  };

  programs = {
    jujutsu = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        user.name = "James Sully";
        user.email = "sullyj3@gmail.com";
        ui.default-command = "log";
      };
    };
    # nushell.enable = true;
    # zoxide.enableNushellIntegration = true;
  };

}
