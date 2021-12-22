function glo --wraps='git log --online' --wraps='git log --oneline' --description 'alias glo=git log --oneline'
  git log --oneline $argv; 
end
