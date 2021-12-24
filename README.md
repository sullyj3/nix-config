# Home Manager Config

## Usage

1) Install nix
2) Install home-manager
3) Clone into `~/.nixpkgs`
4) `ln -s machine_specific_config.nix home.nix`
5) `home-manager switch`
6) git clone git@github.com:sullyj3/cheatsheets.git ~/.config/cheat/cheatsheets/personal
7) If using a non-NixOS GUI distro, add the following line to `~/.profile` ([why](#Why-do-I-need-to-tweak-XDG_DATA_DIRS)):
	`export XDG_DATA_DIRS="/home/james/.nix-profile/share:$XDG_DATA_DIRS"`
	TODO this is not quite accurate see ~/.profile on dorian
8) There's an issue that prevents gh from authenticating correctly when installed with programs.enable. See nix-community/home-manager#1654. The fix is to 
	1) Edit common.nix, disabling gh and adding it to home.packages
	2) Authenticate as usual
	3) Change common.nix back

## Why do I need to tweak XDG_DATA_DIRS

This is necessary to get desktop entries (used for icons/entries in application launchers) for installed graphical applications. See [this comment](https://github.com/nix-community/home-manager/issues/1439#issuecomment-673770925). Hopefully that issue is closed the next time I read this and I can remove this step.

## TODO

- Automate some of these steps this is getting a bit wack. At least make a "do nothing script"
- I don't have access to fancy fonts on WSL. I should make provisions for that, eg starship wants to use fancy symbols.
- add cheat config
