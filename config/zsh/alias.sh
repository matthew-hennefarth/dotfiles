#!/bin/sh

# My Aliases
alias sudo='sudo '
alias bridges2='ssh bridges2'
alias midway3='ssh midway3'
alias midway3-amd='ssh midway3-amd'
alias tmux='tmux -f ${HOME}/.config/tmux/tmux.conf'
alias cfg='nvim ${XDG_CONFIG_HOME-$HOME/.config}'
alias cfgz='nvim $ZDOTDIR'
alias neomutt='stty discard undef; neomutt'
which eza &> /dev/null && alias ls="eza --icons=auto --color=auto"
which rg &> /dev/null && alias grep="rg"
which xbps-install &> /dev/null && alias void-install=xbps-install
which xbps-query &> /dev/null && alias void-query=xbps-query
which xbps-remove &> /dev/null && alias void-remove=xbps-remove
