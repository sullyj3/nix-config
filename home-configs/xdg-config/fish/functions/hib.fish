hib is a function with definition
# Defined via `source`
function hib --wraps='sudo systemctl hibernate' --description 'alias hib=sudo systemctl hibernate'
  sudo systemctl hibernate $argv
        
end
