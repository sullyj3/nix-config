# Archlabs on laptop

{ config, pkgs, specialArgs, ... }:

{
  imports = [ ./home.nix ./genericLinux.nix ./guiLinux.nix ];

  home = {
    sessionVariables = { BROWSER = "google-chrome-stable"; };
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
      feh =
        "feh --draw-filename --force-aliasing --auto-zoom --sort filename --version-sort";
    };
    packages = with pkgs; [
      # doesn't seem to work on WSL, leave it here for now
      nodejs_20
      signal-desktop
      litecli

      texlive.combined.scheme-small
      pandoc
      yai
      meld

      # just want this for vipe, a command that lets you edit piped text in $EDITOR
      moreutils
    ] ++ [
      specialArgs.uiua
    ];
  };

  programs = {
    nushell.enable = true;
    zoxide.enableNushellIntegration = true;

    comodoro = {
      enable = true;
      settings = {
        pomodoro = {
          preset = "pomodoro";
          tcp-host = "localhost";
          tcp-port = 9999;

          on-server-start  = "notify-send '🍅 Pomodoro' 'Server started!'";
          on-server-stopping = "notify-send '🍅 Pomodoro' 'Server stopping…'";
          on-server-stop  = "notify-send '🍅 Pomodoro' 'Server stopped!'";

          on-timer-start = "notify-send '🍅 Pomodoro' 'Timer started!'";
          on-timer-stop = "notify-send '🍅 Pomodoro' 'Timer stopped!'";

          on-work-pause = "notify-send '🍅 Pomodoro' 'Timer paused!'";
        };
      };
    };
  };

  services = {
    batsignal.enable = true;
    comodoro = {
      enable = true;
      preset = "pomodoro";
      protocols = ["tcp"];
    };
  };

}
