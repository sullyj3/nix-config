function callPackage
    set -l file $argv[1]
    set -l expr "(import (builtins.getFlake \"nixpkgs\") {}).callPackage $file {}"
    nix build --impure --expr $expr
end
