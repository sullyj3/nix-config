# Defined in /tmp/fish.FBR2Zv/try.fish @ line 2
function try --wraps='nix-shell -p'
  nix-shell -p $argv --run fish; 
end
