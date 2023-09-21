# For non-NixOS linux systems

{ config, pkgs, ... }:

{
  # This is a good idea according to https://nixos.wiki/wiki/Home_Manager
  # "Home Manager has an option to automatically set some environment variables that will ease usage of software installed with nix on non-NixOS linux (fixing local issues, settings XDG_DATA_DIRS, etc.)"
  targets.genericLinux.enable = true;

  # TODO extract to non nixOS module
  # TODO What the heck is this thing for again?

  # TODO we are currently setting $XDG_CONFIG_HOME/fish/functions to a nix 
  # store path in common.nix. It seems like this is making plugins that install
  # functions (like nvm.fish) silently fail.
  # may have to refactor to use programs.fish.functions
  # this is a little irritating, since we won't get syntax highlighting
  programs.fish.plugins = [{
    name = "nvm";
    src = pkgs.fetchFromGitHub {
      owner = "jorgebucaran";
      repo = "nvm.fish";
      rev = "9db8eaf6e3064a962bca398edd42162f65058ae8";
      sha256 = "1sffqgvqw4vwljrfkf828mp2gxrvvbcwf2v6chj73rd27s5ajh1f";
    };
  }];
}
