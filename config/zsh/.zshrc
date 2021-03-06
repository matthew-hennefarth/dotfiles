#!/bin/zsh

# Adds color to ls output
export CLICOLOR=1

# Change the LS color output from blue (directory) to magenta
export LSCOLORS=fxGxcxdxbxegedabagacad

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[magenta]%}%c%{$reset_color%} %%%b "
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.cache/zsh/zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Disable globbing on the remote path.
alias scp='noglob scp_wrap'
function scp_wrap {
  local -a args
  local i
  for i in "$@"; do case $i in
    (*:*) args+=($i) ;;
    (*) args+=(${~i}) ;;
  esac; done
  command scp "${(@)args}"
}

# Disable rm ./* from prompting a confirmation
setopt rmstarsilent

# My Aliases
alias hoffman='ssh hoffman'
#alias bridges='ssh bridges'
alias bridges2='ssh bridges2'
alias vmd='/Applications/VMD\ 1.9.4a51-arm64-Rev9.app/Contents/vmd/vmd_MACOSXARM64'

#alias python3='/opt/homebrew/bin/python3'
#alias pip3='/opt/homebrew/bin/pip3'

# Load zsh-syntax-highlighting; should be last.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
