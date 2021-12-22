{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "james";
  home.homeDirectory = "/home/james";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

	# This is a good idea according to https://nixos.wiki/wiki/Home_Manager
	# the page doesn't really elaborate much as to why
	targets.genericLinux.enable = true;

  programs = {
    git = {
      enable = true;
      userName  = "James Sully";
      userEmail = "sullyj3@gmail.com";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    nnn
    ripgrep
    exa
    fd
    zoxide
    starship
    gh
    bat
    fzf
    niv
    tree
    dua
    tealdeer
    htop

    neovim
  ];

  xdg.configFile."nvim/init.lua".source = ./config/nvim/init.lua;
  xdg.configFile."fish/config.fish".source = ./config/fish/config.fish;
}
