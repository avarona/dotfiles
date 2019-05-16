#!/usr/bin/env bash



install_all() {
  for file in */install.sh
  do
    echo $file
    if test ! -x $file
    then
      chmod +x $file
    fi

    echo "Installing ${file%/*}..."
    $file

    echo "Done"
  done
}

symlinks() {
  echo "Creating symlinks..."
  for file in */*.symlink
  do
    from_path=${file%*.symlink}
    to_path=~/.${from_path#*/}

    ln -sf $from_path $to_path
  done
  echo "Done"
}

install_all
