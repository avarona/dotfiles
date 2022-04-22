# Command line scripts
export PATH=$PATH:~/bin

# Homebrew installed
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# ASDF installed through homebrew
. $(brew --prefix asdf)/asdf.sh

# Android development
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK=$ANDROID_SDK/lib
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
