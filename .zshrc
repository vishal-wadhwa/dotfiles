# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/zomato/.oh-my-zsh"

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
plugins=(git colored-man-pages common-aliases zsh-autosuggestions you-should-use zsh-syntax-highlighting) #osx)

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

go1="$HOME/go"
go2="$HOME/go-2"
export GOPATH="$go1:$go2"
export GOBIN="$go1/bin"
# this does not set gobin for go-2; it must be explicitly set for go-2
export GOBIN2="$go2/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:$GOBIN:$GOBIN2"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/bin"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="$PATH:$HOME/Library/Python/3.7/bin"

# you_should_use extension
export YSU_MESSAGE_POSITION="after"

alias sudo='sudo '

alias tcheat='cat ~/.zcode/tmux_cheats.txt'

alias mntz="sshfs vishalwadhwa.eks.zdev.net:/var/www/zomato9 ~/zdev -oauto_cache,reconnect,defer_permissions,noappledouble,cache=yes,kernel_cache,cache_timeout=3600" #compression=no -> may not be useful
alias umntz="diskutil unmount force ~/zdev"

# alias nvm="echo 'nvm has been disabled. Enable it in ~/.zshrc'"
# zprof

if [ -f ~/.docker_aliases.sh  ]; then
    . ~/.docker_aliases.sh
fi

if [ -f ~/bin/zsh.command-not-found ]; then
    . ~/bin/zsh.command-not-found
fi

# export GO111MODULE=on

alias myip='ifconfig en0 | grep inet'

alias gcd='git checkout dev'
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwr='git worktree remote'
alias gcv="git cherry -v"
alias grel="git tag --format '%(align:25,right)%(creatordate:local)%(end) | %(refname:short) released about %(creatordate:relative) by %(authorname)' --contains"

eval $(thefuck --alias)

# ulimit -n 200000 200000
# ulimit -u 2048 2048
alias tree="tree -C"

unalias run-help 2>/dev/null
autoload run-help
alias help=run-help

function urlencode() { jq -nr --arg v "$1" '$v|@uri'; }
function urldecode() { printf $(echo -n $@ | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')"\n" }

# deeplink encode/decode
function dlenc() {
    urlencode $(echo -n "$1" | base64)
}
function dldec() {
    urldecode "$1" | base64 -D
}

# mac proxy
alias setpxy="networksetup -setwebproxystate wi-fi on; networksetup -setsecurewebproxystate wi-fi on"
alias usetpxy="networksetup -setwebproxystate wi-fi off; networksetup -setsecurewebproxystate wi-fi off"

# dotfiles setup
# https://www.atlassian.com/git/tutorials/dotfiles
# TODO: write setup script and add to repo readme
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if [ $((RANDOM%10)) -eq 0 ]; then
   fortune | cowsay -f $(ls /usr/local/Cellar/cowsay/3.04/share/cows | shuf -n 1) | lolcat -a -f -t -s 5000 || true
fi
