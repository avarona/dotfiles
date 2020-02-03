# Command line scripts
export PATH=$PATH:~/bin

# NPM installed
export PATH=/usr/local/share/npm/bin:$PATH

# Homebrew installed
export PATH="/usr/local/sbin:$PATH"

# Yarn installed through homebrew
export PATH="$PATH:`yarn global bin`"

# ASDF installed through repo
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

# Android development
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools