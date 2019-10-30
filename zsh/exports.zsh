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
