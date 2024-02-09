export PATH=$HOME/Library/Android/sdk/cmdline-tools/latest/bin:\
$HOME/Library/Android/sdk/platform-tools:\
$HOME/jschear/bin:\
$HOME/.deno/bin:\
$HOME/.cargo/bin:\
$PATH

# Garmin connect SDK
export PATH=$PATH:$(cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg)bin

# Add Visual Studio Code (code)
# Someday we'll install this with nix.
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

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
alias ls='ls -GF'

# xcode
alias clean-dd="rm -rf $HOME/Library/Developer/Xcode/DerivedData"

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

# opam
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# NVM/node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
