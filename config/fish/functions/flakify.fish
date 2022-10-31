# adapted from https://github.com/nix-community/nix-direnv/wiki/Shell-integration
function flakify
  if [ ! -e flake.nix ];
    nix flake new -t github:nix-community/nix-direnv .
  else if [ ! -e .envrc ];
    echo "use flake" > .envrc
    direnv allow
  end
  $EDITOR flake.nix
end
