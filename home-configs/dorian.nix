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
    };
    packages =
      with pkgs;
      [
        pandoc
	ugrep
	gping
      ]
      ++ [
        # specialArgs.whatever
      ];
  };

  # Build aarch64 natively via qemu-user binfmt (Arch's qemu-user-static-binfmt)
  # so builds for the Pi get cache.nixos.org hits instead of cross-compiling.
  # Forwarded to the daemon since we're a trusted user.
  nix.settings.extra-platforms = [ "aarch64-linux" ];
}
