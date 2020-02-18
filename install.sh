#!/usr/bin/env bash

file_permissions() {
  echo "Number of installs..."
  for file in $(find ~/dotfiles -name install.sh)
  do
    echo $file
    if ! [[ -x $file ]]
    then
      chmod +x $file
      echo "Permissions granted!"
    else
      echo "Alreay have permissions"
    fi
  done
}

install_all() {
  for file in */install.sh
  do
    $file
  done
}

symlinks() {
  echo "Creating symlinks..."
  for file in */*.symlink
  do
    prefix=${prefix#*/}
    suffix=${file%*.symlink}

    from_path=$(pwd)/${file}
    to_path=~/.${suffix#*/}

    ln -sf $from_path $to_path
    echo >> $to_path
  done
  echo "Done"
}

bin_scripts() {
  if ! [[ -f ~/bin ]]
  then
    cp bin/ ~
  fi

  chmod -R +x ~/bin
  echo "Done"
}

# Order of installation
# echo "Would you like to install the following packages?"
# ARR=()
# for file in */install.sh
# do
#   printf "$file [y/n] : "
#   read response
#   ARR+=($response)
# done
#
# echo ${ARR[@]}

file_permissions
# install_all
# symlinks
# bin_scripts
