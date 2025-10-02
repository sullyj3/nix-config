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
      BROWSER = "firefox";
    };
    shellAliases = {
      # Set keyboard backlight brightness (0,1,2)
      kbright = "brightnessctl --device='dell::kbd_backlight' set";
      feh = "feh --draw-filename --force-aliasing --auto-zoom --sort filename --version-sort";
    };
    packages =
      with pkgs;
      [
        texlive.combined.scheme-small
        pandoc
        netcat

        # just want this for vipe, a command that lets you edit piped text in $EDITOR
        moreutils
      ]
      ++ [
        # specialArgs.whatever
      ];
  };

  programs = {
    nushell.enable = true;
    zoxide.enableNushellIntegration = true;
  };

  services = {
  };
}
