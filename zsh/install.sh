#!/usr/bin/env bash

echo "
|----------------------------------------------|
|                     ZSH                      |
|----------------------------------------------|
"

install_zsh() {
  # check what shell
  # check if installed
  echo $shell
  shell=which $SHELL
  if [[ $shell = /bin/zsh ]]
  then
    echo $SHELL
  fi
  #   brew install zsh
  # else
  # done
}

symlinks() {
  # check for .zsh directory to house zsh exports
  if ! [[ -d ~/.zsh ]]
  then
    mkdir ~/.zsh
  fi

  # link *.zsh files in ~/.zsh
  for file in zsh/*.zsh
  do
    prefix=${file#*/}

    from_path=$(pwd)/${file}
    to_path=~/.zsh/$prefix

    if [[ -L $to_path && -f $to_path ]]
    then
      echo $file "already linked"
    else
      ln -sf $from_path $to_path
      echo >> $to_path
    fi
  done

  # link .zshrc to ~
  for file in zsh/*.symlink
  do
    prefix=${file#*/}
    suffix=${prefix%*.symlink}

    from_path=$(pwd)/${file}
    to_path=~/.${suffix#*/}

    if [[ -L $to_path && -f $to_path ]]
    then
      echo $file "already linked"
    else
      ln -sf $from_path $to_path
      echo >> $to_path
    fi
  done
}

install_zsh
# symlinks
