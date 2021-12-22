function gcv --wraps='git commit --verbose' --description 'alias gcv=git commit --verbose'
  git commit --verbose $argv; 
end
