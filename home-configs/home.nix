# This module contains niceties and is relatively heavyweight, it shouldn't 
# necessarily be included in all configs (eg remote servers).
# For lighter configs use ./basics.nix

{ config, pkgs, lib, ... }:
let
  myLib = import ./myLib.nix { inherit config; };
in
{
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
      ouch                        # easy to use compression tool
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
      shellInit = ''
        # ocaml env setup
        source /home/james/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
      '';
      interactiveShellInit = ''
        git_check ${myLib.homeConfigLocation} 'Nix config repository'
        git_check ${config.home.homeDirectory}/.config/cheat/cheatsheets/personal 'Cheatsheets'
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
    btop.enable = true;
  };

  xdg.configFile = {
    "cheat/conf.yml".source = myLib.xdgConf + /cheat/conf.yml;
    "nvim/init.lua".source = myLib.link myLib.xdgConf + /nvim/init.lua;
    "nvim/ftplugin".source = myLib.xdgConf + /nvim/ftplugin;
  };
}
