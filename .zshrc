# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# private vars
. ~/.private.env

# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="random"
# mortalscumbag
# typewritten/typewritten

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf git colored-man-pages common-aliases zsh-autosuggestions you-should-use zsh-syntax-highlighting) #osx)

# typewritter theme vars
export TYPEWRITTEN_CURSOR="block"
export TYPEWRITTEN_MULTILINE=true

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8  

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# zsh-autosuggest fast paste
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish


export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

# https://github.com/nvm-sh/nvm/issues/1277#issuecomment-536218082
export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# load node without nvm
export PATH="$NVM_DIR/versions/node/$(cat $NVM_DIR/alias/$(cat $NVM_DIR/alias/$(cat $NVM_DIR/alias/default)))/bin:$PATH"
# works after running nvm twice
alias nvm="unalias nvm; [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" && [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" &&  nvm $@"


export PATH="$PATH:$GOBIN"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/bin"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="$PATH:$HOME/Library/Python/3.7/bin"

# you_should_use extension
export YSU_MESSAGE_POSITION="after"

alias sudo='sudo '

alias mntz="sshfs $_WORKBOX_SRC_DIR $_WORKBOX_DEST_DIR -oauto_cache,reconnect,defer_permissions,noappledouble,cache=yes,kernel_cache,cache_timeout=3600" #compression=no -> may not be useful
alias umntz="diskutil unmount force $_WORKBOX_DEST_DIR"

# zprof

if [ -f ~/.docker_aliases.sh  ]; then
    . ~/.docker_aliases.sh
fi

if [ -f ~/bin/zsh.command-not-found ]; then
    . ~/bin/zsh.command-not-found
fi


alias myip='ifconfig en0 | grep inet'

alias gcd='git checkout dev'
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwr='git worktree remote'
alias gcv="git cherry -v"
alias grel="git tag --format '%(align:25,right)%(creatordate:local)%(end) | %(refname:short) released about %(creatordate:relative) by %(authorname)' --contains"

eval $(thefuck --alias)

alias tree="tree -C"

unalias run-help 2>/dev/null
autoload run-help
alias help=run-help

function urlencode() { jq -nr --arg v "$1" '$v|@uri'; }
function urldecode() { printf $(echo -n $@ | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')"\n" }

# url+base64 encode/decode
function b64uenc() {
    urlencode $(echo -n "$1" | base64)
}
function ub64dec() {
    urldecode "$1" | base64 -D
}

# mac proxy
alias setpxy="networksetup -setwebproxystate wi-fi on; networksetup -setsecurewebproxystate wi-fi on"
alias usetpxy="networksetup -setwebproxystate wi-fi off; networksetup -setsecurewebproxystate wi-fi off"

alias tmux="env TERM=screen-256color tmux"


# dotfiles setup
# https://www.atlassian.com/git/tutorials/dotfiles
# TODO: write setup script and add to repo readme
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export LESS=-iR
[ -f ~/.less_termcap ] && . ~/.less_termcap


# font test
# echo -e 'Normal, \x1b[1mbold\x1b[22m, \x1b[3mitalic\x1b[23m, \x1b[1;3mbold italic\x1b[22;23m'

if [ $((RANDOM%15)) -eq 0 ]; then
    fortune | cowsay -f $(ls /usr/local/Cellar/cowsay/3.04/share/cows | shuf -n 1) | lolcat -a -f -t -s 5000 || true
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
