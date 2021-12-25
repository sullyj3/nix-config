# Home Manager Config

## Usage

1) Install prerequisites:
	1) Nix - https://nixos.org/manual/nix/stable/installation/installing-binary.html
	2) home-manager - https://rycee.gitlab.io/home-manager/index.html#ch-installation
2) ```git clone git@github.com:sullyj3/home-manager-config.git ~/.nixpkgs```
3) Create a new machine specific config and build it
	1) `cd ~/.nixpkgs`
	2) `cp dorian.nix my_new_machine.nix` and edit as appropriate
	3) `ln -s my_new_machine.nix home.nix`
	4) `home-manager switch`
4) Post install steps:
 	1) There's an issue that prevents `gh` from authenticating correctly when installed with programs.enable. See [nix-community/home-manager#1654](https://github.com/nix-community/home-manager/issues/1654) and [cli/cli#4955](https://github.com/cli/cli/issues/4955). The workaround is to 
		1) Edit `common.nix`, disabling gh and adding it to home.packages
		2) Authenticate as usual
		3) Change `common.nix` back
	2) Set up `cheat`[^1]. Once it has downloaded community cheatsheets, do

	```git clone git@github.com:sullyj3/cheatsheets.git ~/.config/cheat/cheatsheets/personal```

	3) If using a non-NixOS GUI distro, add the following line to `~/.profile` ([why](#Why-do-I-need-to-tweak-XDG_DATA_DIRS)):

	```export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"```

	

## Why do I need to tweak XDG_DATA_DIRS

This is necessary to get desktop entries (used for icons/entries in application launchers) for installed graphical applications. See [this issue](https://github.com/nix-community/home-manager/issues/1439#issuecomment-1000693014). Hopefully that issue is closed the next time I read this and I can remove this step.

## TODO

- Automate some of these steps this is getting a bit wack. At least make a "[do nothing script](https://blog.danslimmon.com/2019/07/15/do-nothing-scripting-the-key-to-gradual-automation/)"
- Add `cheat` config.[^1]

[^1]: Not sure how to get `cheat` to understand that it needs to download community cheatsheets if there is already a config there. Maybe open an issue?
