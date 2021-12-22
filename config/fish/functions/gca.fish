function gca --wraps='git commit --all --verbose' --description 'alias gca=git commit --all --verbose'
  git commit --all --verbose $argv; 
end
