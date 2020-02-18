# Command line scripts
export PATH=$PATH:~/bin

# NPM installed
export PATH=/usr/local/share/npm/bin:$PATH

# Homebrew installed
export PATH="/usr/local/sbin:$PATH"

# ASDF installed through repo
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

# Android development
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK=$ANDROID_SDK/lib
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
