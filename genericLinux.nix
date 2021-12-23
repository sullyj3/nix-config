# For non-NixOS linux systems

{ config, pkgs, ... }:

{
  # This is a good idea according to https://nixos.wiki/wiki/Home_Manager
  # the page doesn't really elaborate much as to why
  targets.genericLinux.enable = true;

  # TODO extract to non nixOS module
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
