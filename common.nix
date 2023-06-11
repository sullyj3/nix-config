{ config, pkgs, lib, ... }:
{
  # true by default, this is here as a reminder.
  # `man home-configuration.nix`
  manual.manpages.enable = true;

  # `home-manager-help` opens manual in browser
  manual.html.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      RIPGREP_CONFIG_PATH = "/home/james/.config/ripgrep/ripgreprc";
      NEOVIDE_MULTIGRID = "true";
    };

    sessionPath = [
      "/home/james/.cabal/bin"
      "/home/james/.ghcup/bin"
      "/home/james/.elan/bin"
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

      nv = "neovide";

      # show a tree of all files tracked by git
      repo = "exa --git-ignore -T";

      # Useful for viewing multiple small files at once
      # show filename headers but not the grid
      bats = "bat --style=header,numbers";
      todo = "rg -i todo";
    };

    packages = with pkgs; [
      cbqn # array language
      oil # shell
      just

      du-dust                     # space usage 
      dua                         # space usage 
      glow                        # console md viewer
      neovim-nightly
      ripgrep
      fd                          # ergonomic bfs find
      tree
      pgcli                       # postgres cli
      difftastic
      tomb                        # encryption

      cheat                       # create cheat sheets for commands
      tealdeer                    # brief example driven man pages
      sumneko-lua-language-server
      httpie
      nix-tree
      darkhttpd                   # small http server

      scc                         # source code line counter
      flyctl

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
      aliases = {
        hash = "show --pretty=format:\"%H\" --no-patch";
      };
      extraConfig = {
        init.defaultBranch = "main";
        # diff.external = "difft";
      };
    };
    jq.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global.load_dotenv = true;
      };
    };
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
    # Todo migrate to programs.fish.functions. Having the 
    # ./config/fish/functions directory be a store path is messing with the 
    # installation of plugins with functions via programs.fish.plugins
    # see: https://rycee.gitlab.io/home-manager/options.html#opt-programs.fish.functions
    # see: https://github.com/nix-community/home-manager/blob/ff5133843c26979f8abb5dd801b32f40287692fa/modules/programs/fish.nix#L32
    # see: https://fishshell.com/docs/current/cmds/function.html
    "fish/functions".source = ./config/fish/functions;
    "nvim/init.lua".source = ./config/nvim/init.lua;
    "nvim/ftplugin".source = ./config/nvim/ftplugin;
    "ripgrep/ripgreprc".source = ./config/ripgrep/ripgreprc;
  };
}
