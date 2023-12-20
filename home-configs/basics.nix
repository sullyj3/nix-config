{ config, pkgs, lib, ... }:
let
  username = "james";
  myLib = import ./myLib.nix { inherit config; };
in {
  imports = [ ];

  nix.package = pkgs.nix;

  nix.settings = {
    keep-derivations = true;
    keep-outputs = true;
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    max-jobs = "auto";
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cache.iog.io"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
      "haskell-language-server.cachix.org-1:juFfHrwkOxqIOZShtC4YC1uT1bBcq2RSvC7OMKx0Nz8="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  home = {
    username = username;
    stateVersion = "23.11";
    homeDirectory = /home + "/${username}";

    activation.recordNixAndHMPaths =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD echo ${config.nix.package} > ${config.home.homeDirectory}/tmp/latest-nix
        $DRY_RUN_CMD echo ${pkgs.home-manager} > ${config.home.homeDirectory}/tmp/latest-home-manager
      '';

    enableNixpkgsReleaseCheck = true;

    sessionVariables = {
      EDITOR = "nvim";
      # this is doing weird things, disable for now
      # MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };

    # TODO add 'bakup'
    shellAliases = {
      del = "trash-put";
      rm =
        "echo 'use `del` instead. If you really want to rm, use `command rm`'";

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
      ls = "eza";
      l = "eza";
      la = "eza -a";

      # show a tree of all files tracked by git
      repo = "eza --git-ignore -T";

      # Useful for viewing multiple small files at once
      # show filename headers but not the grid
      bats = "bat --style=header,numbers";
      todo = "rg -i todo";

      yy = "yyp yank";
      p = "yyp put";

      space = "df -H|rg '/$'|tr -s ' '|cut -d ' ' -f 5";

      nps = "nix search nixpkgs";
    };

    packages = with pkgs; [
      config.nix.package
      neovim
      fd # ergonomic bfs find
      tree
      httpie
      eza
      trash-cli

      # mine
      yyp
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    fish.enable = true;
    starship.enable = true;
    starship.enableFishIntegration = true;
    bat.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd j" ];
    };
    git = {
      enable = true;
      userName = "James Sully";
      userEmail = "sullyj3@gmail.com";
      aliases = { hash = ''show --pretty=format:"%H" --no-patch''; };
      extraConfig = { init.defaultBranch = "main"; };
    };
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };

  services.ssh-agent.enable = true;

  xdg.configFile = {
    "starship.toml".source = myLib.xdgConf + "/starship.toml";
    # Todo migrate to programs.fish.functions. Having the 
    # fish/functions directory be a store path is messing with the 
    # installation of plugins with functions via programs.fish.plugins
    # see: https://rycee.gitlab.io/home-manager/options.html#opt-programs.fish.functions
    # see: https://github.com/nix-community/home-manager/blob/ff5133843c26979f8abb5dd801b32f40287692fa/modules/programs/fish.nix#L32
    # see: https://fishshell.com/docs/current/cmds/function.html
    "fish/functions".source = myLib.xdgConf + "/fish/functions";
    "git/ignore".source = myLib.xdgConf + "/git/ignore";
    "tmux/tmux.conf".source = myLib.xdgConf + "/tmux/tmux.conf";
  };

}
