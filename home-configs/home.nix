# This module contains niceties and is relatively heavyweight, it shouldn't
# necessarily be included in all configs (eg remote servers).
# For lighter configs use ./basics.nix

{
  config,
  pkgs,
  lib,
  ...
}:
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

    # sessionPath is currently broken. Paths are appended, rather than prepended, which means
    # that system binaries take precedence over user ones. I've moved this down to
    # fish's shellInit for now.

    # sessionPath = [
    #   # "/home/james/.local/bin" 
    #   "/home/james/.cabal/bin"
    #   "/home/james/.ghcup/bin"
    #   "/home/james/.elan/bin"
    # ];

    shellAliases = {
      nvim-test-config = "nvim -u ${myLib.homeConfigLocation}/xdg-config/nvim/init.lua";
    };

    packages = with pkgs; [
      cachix
      cbqn # array language
      just

      du-dust # space usage
      dua # space usage
      glow # console md viewer
      pgcli # postgres cli
      difftastic
      tomb # encryption

      cheat # create cheat sheets for commands
      tealdeer # brief example driven man pages
      sumneko-lua-language-server
      nix-tree
      miniserve # small http server

      scc # source code line counter

      streamlink
      nix-output-monitor
      ouch # easy to use compression tool
      choose # simple cut/awk alternative
      oil # shell
      tmsu # tag based file system
      instaloader # instagram downloader

      devenv
      rust-analyzer
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
      shellInitLast = ''
        fish_add_path '~/.local/bin'
        fish_add_path '~/.ghcup/bin'
        fish_add_path '~/.cabal/bin'
        fish_add_path '~/.elan/bin'
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
    # "nvim" = {
    #   source = myLib.xdgConf + /nvim;
    #   recursive = true;
    # };
    "nvim" = {
      source = myLib.link (myLib.homeConfigLocation + "/xdg-config/nvim-2024");
    };
  };
}
