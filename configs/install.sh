#!/usr/bin/env bash

symlinks() {
  echo "Adding config symlinks..."
  for file in configs/*.symlink
  do
    prefix=${file#*/}
    suffix=${prefix%*.symlink}

    from_path=$(pwd)/${file}
    to_path=~/.${suffix#*/}

    if ! [[ -L $to_path && -f $to_path ]]
    then
      ln -sf $from_path $to_path
      echo >> $to_path
      echo prefix
    else
      echo "Symlink already created"
    fi
  done
  echo "Done"
}

symlinks
