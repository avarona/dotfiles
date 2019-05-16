#!/usr/bin/env bash

install_homebrew() {
  if test ! $(which brew)
  then
    echo "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
  else
    echo "Homebrew already installed"
  fi
}

# TODO: check if packages are installed
install_packages() {
  if test -f "brew/brewfile.symlink"
  then
    if test
    echo "Installing packages from brewfile..."
    brew bundle --file="brew/brewfile.symlink"
  else
    echo "No brewfile found"
    echo "Creating one instead..."
    brew bundle dump --file="brew/brewfile.symlink"
    echo "Brewfile created"
  fi
}

install_homebrew
install_packages
