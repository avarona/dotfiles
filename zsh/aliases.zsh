# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

alias zshconfig="nano ~/.zshrc"
alias zshsource="source ~/.zshrc; cp ~/.zshrc ~/dotfiles/zsh/zshrc.symlink"
alias brewup="brew update; brew upgrade; brew prune; brew cleanup; brew doctor"
alias gtail="grc tail -f"
alias cut="git branch | grep -v "master" | xargs git branch -D"
alias loadnvm=". /usr/local/opt/nvm/nvm.sh; nvm use --delete-prefix v10.11.0 --silent"
