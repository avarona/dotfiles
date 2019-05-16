#!/usr/bin/env bash

if ! -d ~/.oh-my-zsh
then
  echo "Installing oh-my-zsh..."
  # sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed"
fi
