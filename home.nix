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

  home.sessionVariables = {
    EDITOR = "nvim";

    # TODO what if we're on WSL? not sure how to handle this correctly
    # more generally this is the reason I haven't started moving gui apps into nix yet
    BROWSER = "google-chrome-stable";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  home.sessionPath = [
    "/home/james/.cabal/bin"
    "/home/james/.ghcup/bin"
  ];

  programs = {
    git = {
      enable = true;
      userName  = "James Sully";
      userEmail = "sullyj3@gmail.com";
    };
    fish = {
      enable = true;
      plugins = [{
        # TODO this is only applicable to non NixOS OSes... wat do?
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
        };
      }];
      shellInit = ''
        if status is-interactive
            zoxide init fish | source
        end
      '';
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  # not sure how to do this with programs.starship.settings:
  xdg.configFile."starship.toml".source = ./config/starship.toml;

  # fish config
  xdg.configFile."fish/functions".source = ./config/fish/functions;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    nnn
    ripgrep
    exa
    fd
    zoxide

    gh
    bat
    fzf
    tree
    dua
    tealdeer
    htop

    neovim
  ];

  xdg.configFile."nvim/init.lua".source = ./config/nvim/init.lua;
}
