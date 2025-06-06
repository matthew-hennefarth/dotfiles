#!/bin/zsh
# zsh profile file. Runs on login. 

# For rust??
source "$HOME/.cargo/env"

# Initialize Homebrew if on system
which /opt/homebrew/bin/brew &> /dev/null && eval $(/opt/homebrew/bin/brew shellenv)

# Additional Environmental Variables
export GPG_TTY=$(tty)
# Launch new agent on new shell
gpgconf --launch gpg-agent

export WORKON_HOME=$HOME/Developer/.venvs
if [ -f ${HOME}/.config/zsh/.zsh_local ]; then
  source ${HOME}/.config/zsh/.zsh_local
fi

# Deal with Virtual Environment
function __venv_activate {
  case "$1" in
    activate)
      if [ $# -lt 2 ]; then
        echo "Must specify an environment to load"
        return 1
      fi
      p=$WORKON_HOME/$2/activate
      if [ -f "$p" ]; then
        source $p
      else
        echo "Environment $2 does not exist"
        return 1
      fi
    ;;
    deactivate)
      deactivate
    ;;
    reload)
      deactivate && venv activate $2
    ;;
    *)
      echo "Unknown command $@"
    ;;
  esac

  return 0
}

function venv {
  local cmd="${1-__missing__}"
  case "$cmd" in
    activate | deactivate | reload )
      __venv_activate "$@"
    ;;
    *)
      echo "Unknown command $@"
      return 1
    ;;
  esac

  return 0
}
