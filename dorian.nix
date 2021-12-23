{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home = {
    username = "james";
    homeDirectory = "/home/james";

    # TODO extract to GUI linux module
    sessionVariables.BROWSER = "google-chrome-stable";

  };

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
