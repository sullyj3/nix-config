{ config, pkgs, ... }:
{
  # true by default, this is here as a reminder.
  # `man home-configuration.nix`
  manual.manpages.enable = true;

  # `home-manager-help` opens manual in browser
  manual.html.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      RIPGREP_CONFIG_PATH = "/home/james/.config/ripgrep/ripgreprc";
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
      gco = "git checkout";
      gdiff = "git diff";
      glo = "git log --oneline";
      gs = "git status";
      gss = "git status --short";
      push = "git push";
      pull = "git pull";

      hm = "home-manager";
      ls = "exa";
      l = "exa";
      la = "exa -a";

      # show a tree of all files tracked by git
      repo = "exa --git-ignore -T";

      # Useful for viewing multiple small files at once
      # show filename headers but not the grid
      bats = "bat --style=header,numbers";
      todo = "rg -i todo";
    };

    packages = with pkgs; [
      du-dust
      glow
      neovim-nightly
      ripgrep
      fd
      tree
      dua
      pgcli
      difftastic

      cheat
      tealdeer
      nodejs
      sumneko-lua-language-server
      httpie
      nix-tree

      # from github.com/ceedubs/unison-nix
      unison-ucm
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    aria2.enable = true;
    broot.enable = true;
    broot.enableFishIntegration = true;
    git = {
      enable = true;
      userName  = "James Sully";
      userEmail = "sullyj3@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        diff.external = "difft";
      };
    };
    jq.enable = true;
    just.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        git_check $HOME/.config/nixpkgs 'Home manager config'
        git_check $HOME/.config/cheat/cheatsheets/personal 'Cheatsheets'
      '';
    };
    starship.enable = true;
    starship.enableFishIntegration = true;
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
    "nvim/ftplugin".source = ./config/nvim/ftplugin;
    "ripgrep/ripgreprc".source = ./config/ripgrep/ripgreprc;
  };
}
