#!/usr/bin/env bash

install_homebrew() {
  if [[ ! $(which brew) ]]
  then
    echo "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
  else
    echo "Homebrew already installed"
  fi
}

# TODO: check if packages are installed
install_packages() {
  if [[ -f "brew/brewfile.symlink" ]]
  then
    if ! check_packages
    then
      echo "equal here"
      brew bundle --file="brew/brewfile.symlink"
    else
      echo "not"
    fi
    echo "Installing packages from brewfile..."
    brew bundle --file="brew/brewfile.symlink"
  else
    echo "No brewfile found"
    echo "Creating one instead..."
    brew bundle dump --file="brew/brewfile.symlink"
    echo "Brewfile created"
  fi
}

# return true or false if brewfile matches installed packages
check_packages() {
  echo "checking packages..."
  BREWFILE=()
  INSTALLED=()

  # Create brewfile array
  while read package
  do
    package=${package#*\"}
    package=${package%\"*}

    BREWFILE+=($package)
  done < brew/brewfile.symlink

  # Create installed packages array
  TAPS=$(brew tap)
  LEAVES=$(brew leaves)
  CASKS=$(brew cask list)

  for tap in $TAPS
  do
    INSTALLED+=($tap)
  done

  for leaf in $LEAVES
  do
    INSTALLED+=($leaf)
  done

  for cask in $CASKS
  do
    INSTALLED+=($cask)
  done

  # Sort arrays
  IFS=$'\n' BREWFILE_SORTED=($(sort <<<"${BREWFILE[@]}"))
  unset IFS

  IFS=$'\n' INSTALLED_SORTED=($(sort <<<"${INSTALLED[@]}"))
  unset IFS

  # Check if arrays are equal
  if [[ -z $(diff <(printf ${BREWFILE_SORTED[@]}) <(printf ${INSTALLED_SORTED[@]})) ]]
  then
    echo "packages match brewfile"
    true
  else
    echo "packages don't match brewfile"
    false
  fi
}

install_homebrew
install_packages
