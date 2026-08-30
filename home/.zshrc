# Environment
export TERMINAL='Terminal'
export TERM='xterm-256color'
export VISUAL='nvim'
export EDITOR='nvim'
export PAGER='less'
export LANG='en_US.UTF-8'

# Custom
export MACFILES="$HOME/.macfiles"

# Configuration
export BAT_THEME='ansi'

# XDG
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_DATA_HOME="$HOME/.local/"
export XDG_CACHE_HOME="$HOME/.cache/"
export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_STATE_HOME="$HOME/.local/state"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export LESSHISTFILE=-

# Shell options
set -o emacs
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt PROMPT_SUBST

# Completions & plugins
autoload -Uz compinit && compinit
autoload -z edit-command-line
autoload -Uz vcs_info
autoload -Uz is-at-least
autoload -U colors && colors

if [[ -r /usr/share/git/completion/git-completion.zsh ]]; then
    source /usr/share/git/completion/git-completion.zsh
fi

# Homebrew on PATH — must precede the plugin block below. Non-login shells
# (e.g. cmux surfaces) skip /etc/zprofile, so path_helper never fires and
# `command -v brew` would otherwise fail on first source. Full HOMEBREW_*
# env setup still happens in the main Homebrew block further down.
if [[ -d /opt/homebrew/bin ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# zsh plugins — sourced from the fixed Homebrew prefix (as above). Do NOT use
# `$(brew --prefix)` here: it spawns a brew subprocess on every startup and, if
# brew is wedged, deadlocks the shell before it ever reaches the prompt.
if [[ -d /opt/homebrew/share ]]; then
    if [[ -d /opt/homebrew/share/zsh-autosuggestions ]]; then
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi

    if [[ -d /opt/homebrew/share/zsh-autocomplete ]]; then
        zstyle ':autocomplete:*' automatic-expansion off
        zstyle ':autocomplete:*' real-time-completion off

        source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

        zstyle ':autocomplete:*' ignored-input '*'

        bindkey -M emacs              '^I'         menu-complete
        bindkey -M emacs "$terminfo[kcbt]" reverse-menu-complete

        bindkey -M emacs \
            "^[p"   .history-search-backward \
            "^[n"   .history-search-forward \
            "^P"    .up-line-or-history \
            "^[OA"  .up-line-or-history \
            "^[[A"  .up-line-or-history \
            "^N"    .down-line-or-history \
            "^[OB"  .down-line-or-history \
            "^[[B"  .down-line-or-history

        zle -N edit-command-line
        bindkey -M emacs '^X^E' edit-command-line
    fi
fi

# prompt
if [[ -n "$SSH_CONNECTION" ]]; then
    export PS1="%n@%m: %~ \$ "
else
    precmd() { vcs_info }

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' use-simple true
    zstyle ':vcs_info:*' check-for-staged-changes true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' stagedstr '*'
    zstyle ':vcs_info:*' unstagedstr 'x'

    local GIT_ON='%Bon '
    local GIT_PREFIX='%B%F{yellow}git:'
    local GIT_BRANCH='%F{magenta}%b'
    local GIT_FLAGS='%F{magenta}(%c%u%a)'
    local GIT_SUFFIX='%f'
    local GIT_PROMPT="${GIT_ON}${GIT_PREFIX}${GIT_BRANCH}${GIT_FLAGS}${GIT_SUFFIX}"

    zstyle ':vcs_info:git*' formats "${GIT_PROMPT}"

    local DIRECTORY='%B%F{cyan}%1~%f%b'
    local GIT='${vcs_info_msg_0_:+ ${vcs_info_msg_0_}}'
    local CHAR=' $ %(?..[%?] )%b%f'

    PROMPT="${DIRECTORY}${GIT}${CHAR}"
    RPROMPT='%(1j.%F{yellow}[%j job%(2j.s.)]%f.)'
fi

export PS2=">> "
export PS4="> "

# PATH & toolchains
export PATH=$PATH:$HOME/.local/bin:$HOME/.bin

# Homebrew
if [[ -d /opt/homebrew ]]; then
    export PATH=$PATH:/opt/homebrew/bin:/opt/homebrew/sbin
fi

# Python
if [[ -d $HOME/Library/Python/3.9/bin ]]; then
    export PATH=$PATH:$HOME/Library/Python/3.9/bin
fi

# Lua
if command -v lua &>/dev/null; then
    export LUA_PATH=";;$HOME/Documents/programs/debugger.lua/?.lua"
    export PATH=$PATH:$HOME/.luarocks/bin
    if [[ -d $HOME/Documents/programs/lua-language-server ]]; then
        export PATH=$PATH:$HOME/Documents/programs/lua-language-server/bin
    fi
fi

# Ruby
if command -v ruby &>/dev/null; then
    export GEM_HOME="$HOME/.gems"
    export PATH=$PATH:$HOME/.local/gem/ruby/3.0.0/bin:$HOME/.gems/bin
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
fi

# Go
if command -v go &>/dev/null; then
    export GOPATH="$HOME/.go"
    export PATH=$PATH:$GOPATH/bin
fi

# Rust
export CARGO_HOME="$HOME/.cargo/"
export PYLINTHOME="${XDG_DATA_HOME}/pylint"
export IPYTHONDIR="$HOME/.config/ipython/"
export PATH=$PATH:$HOME/.cargo/bin

# Node.js
if command -v npm &>/dev/null; then
    export NPM_CONFIG_PREFIX="$HOME/.node_modules"
    export N_PREFIX="$HOME/.n"
    export NODE="$HOME/.n/bin/node"
    export PATH=$PATH:$HOME/.n/bin:$HOME/.node_modules:$HOME/.node_modules/bin
fi

# Aliases — general
alias v='nvim'
alias tv='NVIM_APPNAME=nvim-test nvim'
alias g='git status'

if command -v bat &>/dev/null || command -v batcat &>/dev/null; then
    alias cat='bat -p'
fi

if command -v eza &>/dev/null; then
    alias l='eza'
    alias ls='eza'
    alias sl='eza'
    alias la='eza -la'
    alias ll='eza -l'
else
    alias ls='ls --color=auto'
    alias sl='ls --color=auto'
    alias la='ls -a --color=auto'
    alias ll='ls -l --color=auto'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias less='less -R'
alias diff='diff --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# Functions
if command -v jq &>/dev/null; then
    js() { jq . "$1"; }
fi

# Integrations — fzf
if command -v fzf &>/dev/null; then
    # shared fd base; file/dir sources differ only by --type
    _fd="fd --follow --hidden --exclude .git --exclude VMs --exclude .cache"
    _fd+=" --exclude .icons --exclude .local --exclude Programs --exclude snap"
    _fd+=" --exclude quicklisp --exclude Music"

    export FZF_DEFAULT_COMMAND="$_fd --type f"
    export FZF_ALT_C_COMMAND="$_fd --type d"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    unset _fd

    [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# Work
[ -f "/Users/dduclos-cavalcanti/Work/zshrc" ] && source "/Users/dduclos-cavalcanti/Work/zshrc"
