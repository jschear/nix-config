export PATH=/Users/jschear/Library/Android/sdk/cmdline-tools/latest/bin:\
/Users/jschear/Library/Android/sdk/platform-tools:\
/Users/jschear/bin:\
$PATH

# Garmin connect SDK
export PATH=$PATH:`cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg`/bin

# nand2tetris
export PATH=$PATH:/Users/jschear/dev/nand2tetris/tools

# Enable autocompletion
autoload -Uz compinit && compinit

# up/down moves through history with prefix
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

## Aliases
# Colorize
alias ls='ls -G'

# xcode
alias clean-dd="rm -rf /Users/jschear/Library/Developer/Xcode/DerivedData"

# gradle
alias gw='./gradlew'

# git
alias gs='git status'
alias gp='git pull'
alias submodules='git pull && git submodule update --init --recursive'

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v1.8)
jdk() {
  version=$1
  export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
  java -version
}

# Android
export ANDROID_HOME=/Users/jschear/Library/Android/sdk

# Add pure to fpath
fpath+=$HOME/.zsh/pure

# Load prompt
autoload -U promptinit; promptinit
prompt pure

# opam configuration
[[ ! -r /Users/jschear/.opam/opam-init/init.zsh ]] || source /Users/jschear/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
