# Defined via `source`
function ywd --wraps='pwd|xclip -i' --description 'alias ywd=pwd|xclip -i'
  pwd|xclip -i $argv

end
