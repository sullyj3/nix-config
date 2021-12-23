{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "james";
    homeDirectory = "/home/james";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";

    sessionVariables = {
      EDITOR = "nvim";

      # TODO what if we're on WSL? not sure how to handle this correctly
      # more generally this is the reason I haven't started moving gui apps into nix yet
      BROWSER = "google-chrome-stable";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };

    sessionPath = [
      "/home/james/.cabal/bin"
      "/home/james/.ghcup/bin"
    ];

    shellAliases = {
      # git stuff
      gaa = "git add --all";
      gcv = "git commit --verbose";
      gca = "git commit --all --verbose";
      gdiff = "git diff";
      glo = "git log --oneline";
      gs = "git status";
      gss = "git status --short";
      push = "git push";
      pull = "git pull";

      hm = "home-manager";
      ls = "exa";
    };

    packages = with pkgs; [
      du-dust
      glow
      neovim
      ripgrep
      fd
      tree
      dua

      cheat
      tealdeer
    ];
  };

  # This is a good idea according to https://nixos.wiki/wiki/Home_Manager
  # the page doesn't really elaborate much as to why
  targets.genericLinux.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    broot = {
      enable = true;
      enableFishIntegration = true;
    };
    git = {
      enable = true;
      userName  = "James Sully";
      userEmail = "sullyj3@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        git_check $HOME/.config/nixpkgs 'Home manager config'
        git_check $HOME/.config/cheat/cheatsheets/personal 'Cheatsheets'
      '';
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
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
    nnn.enable = true;
    exa.enable = true;
    bat.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd j" ];
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
    fzf.enable = true;
    fzf.enableFishIntegration = true;
    htop.enable = true;
  };

  xdg.configFile = {
    "cheat/conf.yml".source = ./config/cheat/conf.yml;
    "starship.toml".source = ./config/starship.toml;
    "fish/functions".source = ./config/fish/functions;
    "nvim/init.lua".source = ./config/nvim/init.lua;
  };
}
