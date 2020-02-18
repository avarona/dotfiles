#!/usr/bin/env zsh

echo "
|----------------------------------------------|
|                     ZSH                      |
|----------------------------------------------|
"

install_oh_my_zsh() {
  if ! [[ -d ~/.oh-my-zsh ]]
  then
    echo "Installing oh-my-zsh..."

    curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
    
    echo "oh-my-zsh installed!"
  else
    echo "oh-my-zsh already installed"
  fi
    # make zsh default shell
    chsh -s /bin/zsh
}

install_powerline_font() {
  if ! [[ -f ~/config/fontconfig/conf.d ]]
  then
    echo "Installing powerline fonts..."

    git clone https://github.com/powerline/fonts.git ~/fonts

    ~/fonts/install.sh

    if ! [[ -d ~/.config ]]
    then
      mkdir ~/.config
    fi
    
    # cp ~/fonts/fontconfig/50-enable-terminess-powerline.conf ~/.config/fontconfig/conf.d

    rm -rf ~/fonts

    echo "Fonts installed!"
  else
    echo "Fonts already installed"
  fi
}

symlinks() {
  # check for .zsh directory to house zsh exports
  if ! [[ -d ~/.zsh ]]
  then
    mkdir ~/.zsh
  fi

  # link *.zsh files in ~/.zsh
  for file in ~/dotfiles/zsh/*.zsh
  do
    from_path=$file
    to_path=~/.zsh/$(basename $file .zsh)

    if [[ -L $to_path ]]
    then
      echo $to_path "already linked"
    else
      ln -sf $from_path $to_path
      echo $file linked!
    fi
  done

  # link .zshrc to ~
  ln -sf ~/dotfiles/zsh/zshrc.symlink ~/.zshrc
  echo ".zshrc linked!"
}

# install ohmyzsh first to set zsh as default
install_oh_my_zsh
install_powerline_font

# create .zsh directory and link .zshrc
symlinks
