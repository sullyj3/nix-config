function hms --wraps='home-manager switch --flake /home/james/.config/nixpkgs#dorian' --description 'alias hms=home-manager switch --flake /home/james/.config/nixpkgs#dorian'
  home-manager switch --flake /home/james/.config/nixpkgs#(hostname) $argv; 
end
