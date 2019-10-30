# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

# ZSH
alias zshconfig="nano ~/.zshrc"
alias zshalias="nano ~/.zsh/aliases.zsh"
alias zshexports="nano ~/.zsh/exports.zsh"
alias zshsource="source ~/.zshrc"

# Logging
alias gtail="grc tail -f"

# React
alias cra="create-react-app"
alias nc="new-component"

# Git
alias cut="git branch | grep -v "master" | xargs git branch -D"

# Homebrew
alias brewup="brew update; brew upgrade; brew cask upgrade; brew cleanup; brew doctor"

# Elixir
alias emix="iex -S mix"
