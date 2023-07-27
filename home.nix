{ config, pkgs, lib, ... }:
{
  imports = [ ./basics.nix ];

  # true by default, this is here as a reminder.
  # `man home-configuration.nix`
  manual.manpages.enable = true;

  # `home-manager-help` opens manual in browser
  manual.html.enable = true;

  home = {
    sessionPath = [
      "/home/james/.cabal/bin"
      "/home/james/.ghcup/bin"
      "/home/james/.elan/bin"
    ];

    packages = with pkgs; [
      cbqn # array language
      just

      du-dust                     # space usage 
      dua                         # space usage 
      glow                        # console md viewer
      pgcli                       # postgres cli
      difftastic
      tomb                        # encryption

      cheat                       # create cheat sheets for commands
      tealdeer                    # brief example driven man pages
      sumneko-lua-language-server
      nix-tree
      darkhttpd                   # small http server

      scc                         # source code line counter

      streamlink
      nix-output-monitor
    ];
  };

  programs = {
    aria2.enable = true;
    broot.enable = true;
    broot.enableFishIntegration = true;
    jq.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global.load_dotenv = true;
      };
    };
    fish = {
      interactiveShellInit = ''
        git_check $HOME/.config/home-manager 'Home manager config'
        git_check $HOME/.config/cheat/cheatsheets/personal 'Cheatsheets'
      '';
    };
    nnn.enable = true;
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
    "nvim/init.lua".source = ./config/nvim/init.lua;
    "nvim/ftplugin".source = ./config/nvim/ftplugin;
  };
}