#!/usr/bin/env bash

echo "
|----------------------------------------------|
|                   OH-MY-ZSH                  |
|----------------------------------------------|
"

install_oh_my_zsh() {
  if ! [[ -d ~/.oh-my-zsh ]]
  then
    echo "Installing oh-my-zsh..."

    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "Done"
  else
    echo "oh-my-zsh already installed"
  fi
}

install_powerline_font() {
  if ! [[ -f ~/config/fontconfig/conf.d ]]
  then
    echo "Installing powerline fonts..."

    git clone https://github.com/powerline/fonts.git ~/fonts

    ~/fonts/install.sh

    cp ~/fonts/fontconfig/50-enable-terminess-powerline.conf ~/.config/fontconfig/conf.d

    rm -rf ~/fonts

    echo "Done"
  else
    echo "Powerline fonts already installed"
  fi
}

install_oh_my_zsh
install_powerline_font
