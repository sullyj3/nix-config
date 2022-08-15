# For non-NixOS linux systems

{ config, pkgs, ... }:

{
  # This is a good idea according to https://nixos.wiki/wiki/Home_Manager
  # "Home Manager has an option to automatically set some environment variables that will ease usage of software installed with nix on non-NixOS linux (fixing local issues, settings XDG_DATA_DIRS, etc.)"
  targets.genericLinux.enable = true;

  # TODO extract to non nixOS module
  # TODO What the heck is this thing for again?
  programs.fish.plugins = [{
    name = "nix-env";
    src = pkgs.fetchFromGitHub {
      owner = "lilyball";
      repo = "nix-env.fish";
      rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
      sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
    };
  }];
}
