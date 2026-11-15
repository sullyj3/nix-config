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
        pandoc
        netcat
	ugrep
	gping

        # just want this for vipe, a command that lets you edit piped text in $EDITOR
        moreutils
      ]
      ++ [
        # specialArgs.whatever
      ];
  };

  # Build aarch64 natively via qemu-user binfmt (Arch's qemu-user-static-binfmt)
  # so builds for the Pi get cache.nixos.org hits instead of cross-compiling.
  # Forwarded to the daemon since we're a trusted user.
  nix.settings.extra-platforms = [ "aarch64-linux" ];

  programs = {
    nushell.enable = true;
    zoxide.enableNushellIntegration = true;
  };

  services = {
    pueue.enable = true;
  };
}
