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

  programs.git = {
    enable = true;
    userName  = "James Sully";
    userEmail = "sullyj3@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = [
    pkgs.bottom
    pkgs.nnn
    pkgs.ripgrep
    pkgs.exa
    pkgs.fd
    pkgs.zoxide
    pkgs.starship
    pkgs.gh
    pkgs.bat
    pkgs.fzf
    pkgs.niv
    pkgs.tree
    pkgs.dua
  ];
}
