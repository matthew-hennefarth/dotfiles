#!/bin/zsh

# Adds color to ls output
export CLICOLOR=1

# Change the LS color output from blue (directory) to magenta
export LSCOLORS=fxGxcxdxbxegedabagacad

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors

function parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1] /p'
}

COLOR_DEF=$'%f'
COLOR_DIR=$'%F{magenta}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%c ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}> '
#PS1="%B%{$fg[magenta]%}%c%{$reset_color%} > "

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
alias bridges2='ssh bridges2'
alias midway3='ssh midway3'
alias midway3-amd='ssh midway3-amd'
alias tmux='tmux -f ${HOME}/.config/tmux/tmux.conf'

# Load zsh-syntax-highlighting; should be last.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
