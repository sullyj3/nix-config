# Home Manager Config

## Usage

1) Install nix
2) Install home-manager
3) Clone into ~/.nixpkgs
4) `ln -s machine_specific_config.nix home.nix`
5) `home-manager switch`
6) In neovim, to install plugins do `:PackerInstall`
7) If using a non-NixOS GUI distro, add the following line to `~/.profile` ([why](#Why-do-I-need-to-tweak-XDG_DATA_DIRS)):
	`export XDG_DATA_DIRS="/home/james/.nix-profile/share:$XDG_DATA_DIRS"`

## Why do I need to tweak XDG_DATA_DIRS

This is necessary to get desktop entries (used for icons/entries in application launchers) for installed graphical applications. See [this comment](https://github.com/nix-community/home-manager/issues/1439#issuecomment-673770925). Hopefully that issue is closed the next time I read this and I can remove this step.
