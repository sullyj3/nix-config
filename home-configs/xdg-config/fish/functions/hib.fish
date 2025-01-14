function hib --wraps='sudo systemctl hibernate' --description 'alias hib=sudo systemctl hibernate'
  sudo systemctl hibernate $argv
        
end
