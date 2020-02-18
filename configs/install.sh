#!/usr/bin/env bash

symlinks() {
  echo "Linking config files..."
  for file in ~/dotfiles/configs/*.symlink
  do
    basename=$(basename $file .symlink)
    from_path=$file
    to_path=~/.$basename

    if [[ -L $to_path ]]
    then
      echo $to_path "alread linked"
    else
      ln -sf $from_path $to_path
      echo .$basename linked!
    fi
  done
}

symlinks
