{ config, pkgs, ... }:
let 
  username = "james";
  myLib = import ./myLib.nix { inherit config; };
in
{
  imports = [];

  nix.package = pkgs.nixVersions.nix_2_16;
  
  nix.settings = {
    keep-derivations = true;
    keep-outputs = true;
    experimental-features = ["nix-command" "flakes" "repl-flake"];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cache.iog.io"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
      "haskell-language-server.cachix.org-1:juFfHrwkOxqIOZShtC4YC1uT1bBcq2RSvC7OMKx0Nz8="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  home = {
    username = username;
    stateVersion = "23.11";
    homeDirectory = /home + "/${username}";

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };

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

      yy = "yyp yank";
      p = "yyp put";

      space = "df -H|rg '/$'|tr -s ' '|cut -d ' ' -f 5";
    };

    packages = with pkgs; [
      neovim
      fd                          # ergonomic bfs find
      tree
      httpie

      yyp
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    fish.enable = true;
    starship.enable = true;
    starship.enableFishIntegration = true;
    exa.enable = true;
    bat.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd j" ];
    };
    git = {
      enable = true;
      userName  = "James Sully";
      userEmail = "sullyj3@gmail.com";
      aliases = {
        hash = "show --pretty=format:\"%H\" --no-patch";
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };

  xdg.configFile = 
  {
    "starship.toml".source = myLib.xdgConf + "/starship.toml";
    # Todo migrate to programs.fish.functions. Having the 
    # fish/functions directory be a store path is messing with the 
    # installation of plugins with functions via programs.fish.plugins
    # see: https://rycee.gitlab.io/home-manager/options.html#opt-programs.fish.functions
    # see: https://github.com/nix-community/home-manager/blob/ff5133843c26979f8abb5dd801b32f40287692fa/modules/programs/fish.nix#L32
    # see: https://fishshell.com/docs/current/cmds/function.html
    "fish/functions".source = myLib.xdgConf + "/fish/functions";
  };

}
