# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

[ -f ~/work/.shrc ] && . ~/work/.shrc

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mortalscumbag"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(kubectl fzf git colored-man-pages common-aliases zsh-autosuggestions you-should-use zsh-syntax-highlighting) #osx)

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

is_mac=$(! [[ $(uname -s) == 'Darwin' ]]; echo $?) # use inverted condition to store 1 for truthy
is_arm=$(! [[ $(uname -p) == 'arm' ]]; echo $?)

export EDITOR="vim"

export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
alias go2=$HOME/code/goroots/go2/bin/go
export PATH="$HOME/code/goroots/go1.13/bin:$PATH"

# https://github.com/nvm-sh/nvm/issues/1277#issuecomment-536218082
export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# load node without nvm
export PATH="$NVM_DIR/versions/node/$(cat $NVM_DIR/alias/$(cat $NVM_DIR/alias/$(cat $NVM_DIR/alias/default)))/bin:$PATH"
# works after running nvm twice
if  [ $is_mac ] && [ $is_arm ]; then
    alias nvm="unalias nvm; [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"; [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm";  nvm $@"
else
    alias nvm="unalias nvm; [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"; [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm";  nvm $@"
fi

alias vi=nvim

export PATH="$PATH:$GOBIN"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/bin"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# you_should_use extension
export YSU_MESSAGE_POSITION="after"

alias sudo='sudo '

# zprof

[ -f ~/.docker_alias ] && . ~/.docker_alias

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
alias unsetpxy="networksetup -setwebproxystate wi-fi off; networksetup -setsecurewebproxystate wi-fi off"

alias tmux="env TERM=screen-256color tmux"


# dotfiles setup
# https://www.atlassian.com/git/tutorials/dotfiles
# TODO: write setup script and add to repo readme
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export LESS=-iRS
[ -f ~/.less_termcap ] && . ~/.less_termcap

# for delta diff pager
export BAT_PAGER="less $LESS"

# font test
# echo -e 'Normal, \x1b[1mbold\x1b[22m, \x1b[3mitalic\x1b[23m, \x1b[1;3mbold italic\x1b[22;23m'

# fixes error: Inappropriate ioctl for device gpg: problem with the agent
export GPG_TTY=$(tty)

if [ -x "$(command -v fortune)" ] && [ -x "$(command -v cowsay)" ] && [ -x "$(command -v lolcat)" ] && [ $((RANDOM%15)) -eq 0 ]; then
    fortune | cowsay -f $(cowsay -l | tail -n +2 | tr ' ' '\n' | shuf -n 1) | lolcat -a -f -t -s 5000 || true
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

alias kcat='docker run --rm -i --network=host edenhill/kcat:1.7.0'

function watchpr() {
    gh pr checks $1 --watch
    osascript -e "display notification \"Checks completed for PR $1\""
}

function setup_python() {
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    eval "$(pyenv init -)" 
    pyenv virtualenvwrapper_lazy
}
setup_python

# Magic to get pyenv 3.8.7 work on M1
# [0] % curl -sSL 'https://raw.githubusercontent.com/Homebrew/formula-patches/master/python/3.8.7.patch' > 3.8.7.patch
# [0] % cat /opt/homebrew/Cellar/pyenv/2.3.9/plugins/python-build/share/python-build/patches/3.8.7/Python-3.8.7/0001-bpo-45405-Prevent-internal-configure-error-when-runn.patch 3.8.7.patch | pyenv install --patch 3.8.7

function kube-merge() {
    if [ -d ~/.kube  ]; then
        files=
        # add all configs to kubeconfig variable
        for file in ~/.kube/*-config; do
            files="$files:$file"
        done
        files="${files#:}" # remove extra prefix colon
        cp ~/.kube/config ~/.kube/config.bkp
        KUBECONFIG=$files kubectl config view --flatten > ~/.kube/config
    fi
}

if  [ $is_mac ] && [ $is_arm ]; then
    # Set PATH, MANPATH, etc., for Homebrew.
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"
    export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
fi
