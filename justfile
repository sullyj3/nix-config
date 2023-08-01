# see:
#	  "`nix flake update --single <name>` is more intuitive than `nix flake lock --update`"
#	  https://github.com/NixOS/nix/issues/5110

update-input input:
	nix flake lock --update-input {{input}}
