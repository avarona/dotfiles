#!/usr/bin/env bash

# Homebrew installations

install_homebrew() {
  if test ! $(which brew)
  then
    echo "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
  else
    echo "Homebrew already installed"
  fi
}

install_packages() {
  if test -f "brew/Brewfile"
  then
    echo "Installing packages from brewfile..."
    brew bundle --file="brew/Brewfile"
  else
    echo "No brewfile found"
    echo "Creating one instead..."
    brew bundle dump --file="brew/Brewfile"
    echo "Brewfile created"
  fi
}

install_homebrew
install_packages
