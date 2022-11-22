#!/usr/bin/env bash 

echo "Really for macos only, though maybe it is possible to use with linux?"

dotfile_dir=`pwd -P`

setup_homebrew() {
  
  echo "Setting up Homebrew"
  if [ "$(uname)" == "Linux" ]; then
    echo "Homebrew not allowed on linux (for me at least)..."
  else
    if test ! "$(command -v brew)"; then 
      echo "Homebrew not installed. Installing."
      # Run as a login shell (non-interactive) so that the script doesn't pause for user input
      curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
      eval $(/opt/homebrew/bin/brew shellenv)
    fi
  fi
}
