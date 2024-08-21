# Archlabs on laptop

{
  config,
  pkgs,
  specialArgs,
  ...
}:

{
  imports = [
    ./home.nix
    ./genericLinux.nix
    ./guiLinux.nix
  ];

  home = {
    sessionVariables = {
      BROWSER = "google-chrome-stable";
    };
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
      feh = "feh --draw-filename --force-aliasing --auto-zoom --sort filename --version-sort";
    };
    packages =
      with pkgs;
      [
        # doesn't seem to work on WSL, leave it here for now
        nodejs_20
        signal-desktop
        litecli

        texlive.combined.scheme-small
        pandoc
        yai
        meld
        netcat

        # just want this for vipe, a command that lets you edit piped text in $EDITOR
        moreutils

        uiua
        helix # text editor
      ]
      ++ [
        # specialArgs.whatever
      ];
  };

  programs = {
    nushell.enable = true;
    zoxide.enableNushellIntegration = true;
    # file browser with previews and zoxide integration
    yazi = {
      enable = true;
      enableFishIntegration = true; # `ya` function switches to cwd on exit
    };
  };

  services = {
  };
}
