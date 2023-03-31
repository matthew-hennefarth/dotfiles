#!/bin/zsh

# Adds color to ls output
export CLICOLOR=1

# Adds colors to man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

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
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$ZSH_COMPDUMP"
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
alias cfg='nvim ${XDG_CONFIG_HOME-$HOME/.config}'
alias cfgz='nvim $ZDOTDIR'
alias neomutt='stty discard undef; neomutt'
which exa &> /dev/null && alias ls="exa --icons --color=auto"

# Load zsh-syntax-highlighting; should be last.
source ${ZSH_SYNTAX_HIGHLIGHTING_ROOT}/zsh-syntax-highlighting.zsh
