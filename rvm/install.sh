#!/usr/bin/env bash

echo "
|----------------------------------------------|
|          Ruby Version Manager (RVM)          |
|----------------------------------------------|
"

install_rvm() {
  if ! [[ -d ~/.rvm ]]
  then
    echo "Installing RVM..."
    curl -sSL https://get.rvm.io | bash
    echo "Done"
  else
    echo "RVM already installed"
  fi
}

symlinks() {
  for file in rvm/*.symlink
  do
    prefix=${file#*/}
    suffix=${prefix%*.symlink}

    from_path=$(pwd)/${file}
    to_path=~/.${suffix#*/}

    if ! [[ -L $to_path && -f $to_path ]]
    then

      ln -sf $from_path $to_path
      echo >> $to_path
    else
      echo "Symlink already created"
    fi
  done
}



install_rvm
symlinks
