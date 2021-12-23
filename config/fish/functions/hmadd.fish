function hmadd --description 'add a package to home manager'
	cp ~/.config/nixpkgs/home.nix ~/.config/nixpkgs/home.nix.bak
	sed -ri "s/(home.packages = with pkgs; \[)/\1\n    $argv/" ~/.config/nixpkgs/home.nix;
	home-manager switch

	if test $status -eq 0
	  echo "Success!"
	else
	  echo "Switching failed, reverting to previous home.nix"
	  cp ~/.config/nixpkgs/home.nix.bak ~/.config/nixpkgs/home.nix
	end
end
