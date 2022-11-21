#!/usr/bin/env bash 

echo "Really for macos only, though maybe it is possible to use with linux?"

dotfile_dir=`pwd -P`

setup_symlinks() {
  echo "Creating symlinks"

  echo "Installing to ~/"
  for config in home/*; do
    target="$HOME/.$(basename ${config})"
    config=${dotfile_dir}/${config}
    if [ -e "$target" ]; then
      echo "~${target#HOME} already exists... Skipping"
    else
      echo "Creating symlink for $config"
      ln -s "$config" "$target"
    fi
  done

  echo "Installing to ~/.config"
  if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config"
    mkdir -p "$HOME/.config"
  fi

  
  for config in config/*; do
    target="$HOME/.config/$(basename ${config})"
    config=${dotfile_dir}/${config}
    if [ -e "$target" ]; then
      echo "~${target#$HOME} already exists... Skipping."
    else
      echo "Creating symlink for $config"
      ln -s "$config" "$target"
    fi
  done

  echo "Installing to ~/.local/bin"
  if [ ! -d "${HOME}/.local/" ]; then
    echo "Creating ~/.local"
    mkdir -p "$HOME/.local"
  fi

}

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
    pushd pkgfiles
    brew bundle
    popd
  fi
}

setup_neovim() {
  echo "Setuping Neovim"
  if test ! "$(command -v nvim)"; then
    echo "Neovim not found"
  else
    nvim --headless +PlugInstall +q
    nvim --headless +UpdateRemotePlugins +q
  fi
}

setup_symlinks
#setup_homebrew
#setup_neovim
