# My DotFiles

Currently only available/known to be working on MacOS. If I ever set up a
linux environment, then I will ensure cross-platform support/setup!

## Themes and Fonts

I use the [gruvbox](https://github.com/morhetz/gruvbox) theme for almost
everything (though I have modified some of the background colors since I like
it a bit darker). For fonts, I love the
[DinaRemasterII](https://github.com/zshoals/Dina-Font-TTF-Remastered), but
unfortunately there is not a NerdFont patch (maybe can do at some point?).
Currently switching between
[Gohu](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Gohu)
(no bold text...) and
[SauceCodePro](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro)
(not really retro vibes). Using [alacritty](https://alacritty.org/) since it
uses a toml configuration which plays nicely with my dotfiles.

## Applications
- alacritty
- gpg
- htop
- neovim
- newsboat
- pass
- tmux
- virtualenv
- zsh

### mail
Currently using neomutt for my email. Using (my) [mutt-wizard](https://github.com/matthew-hennefarth/mutt-wizard) as my setup.
Coupling of things to note:
- might need to do some cleanup of the config files (in the home directory)
- need to get python3 markdown package (will include in the requirements.txt at
  some point)

## Todo

- [ ] upgrade from exa to [eza](https://github.com/eza-community/eza).
- [ ] add alias for ripgrep (`alias grep=rg`). Though this will have consequences.
- [ ] Update tmux status weather to cache results
- [ ] clean-up tmux-status configuration into better scripts...
