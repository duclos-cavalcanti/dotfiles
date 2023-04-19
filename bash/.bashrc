# bash
# If not running interactively return
case $- in
  *i*) ;;
    *) return
esac

# Sourcing bash's basic completion
if [ -r /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# Sourcing git's basic completion
if [ -r /usr/share/git/completion/ ]; then
  . /usr/share/git/completion/git-completion.bash
fi

# Sourcing git's prompt information
if [ -r /usr/share/git/completion/ ]; then # arch
    . /usr/share/git/completion/git-prompt.sh
elif [ -r /etc/bash_completion.d/ ]; then # ubuntu
    . /etc/bash_completion.d/git-prompt
fi

# fzf for arch and ubuntu
if command -v fzf &>/dev/null; then
    fzf_dirs=(
    /usr/share/fzf/key-bindings.bash
    /usr/share/fzf/completion.bash
    /usr/share/bash-completion/completions/fzf
    /usr/share/doc/fzf/examples/key-bindings.bash
    )
    for d in ${fzf_dirs[@]}; do
        [ -e ${d} ] && . ${d}
    done
fi

bash_prompt() {
# Prompt info
    # Colors             Backgrounds              Attributes
    #
    # Black   30         Black      40            Normal      0
    # Red     31         Red        41            Bold/Light  1
    # Green   32         Green      42            Dim Text    2
    # Yellow  33         Yellow     43            Underlined  4
    # Blue    34         Blue       44            Blinking    5
    # Purple  35         Purple     45            Reversed    7
    # Cyan    36         Cyan       46            Hidden      8
    # White   37         White      47

    local black='\[\033[00;30m\]'
    local red='\[\033[00;31m\]'
    local green='\[\033[00;32m\]'
    local yellow='\[\033[00;33m\]'
    local blue='\[\033[00;34m\]'
    local purple='\[\033[00;35m\]'
    local cyan='\[\033[00;36m\]'
    local white='\[\033[00;37m\]'
    local clear='\[\033[0m\]'

    local light_black='\[\033[00;90m\]'
    local light_red='\[\033[00;91m\]'
    local light_green='\[\033[00;92m\]'
    local light_yellow='\[\033[00;93m\]'
    local light_blue='\[\033[00;94m\]'
    local light_purple='\[\033[00;95m\]'
    local light_cyan='\[\033[00;96m\]'
    local light_white='\[\033[00;97m\]'

    local bold_black='\[\033[01;30m\]'
    local bold_red='\[\033[01;31m\]'
    local bold_green='\[\033[01;32m\]'
    local bold_yellow='\[\033[01;33m\]'
    local bold_blue='\[\033[01;34m\]'
    local bold_purple='\[\033[01;35m\]'
    local bold_cyan='\[\033[01;36m\]'
    local bold_white='\[\033[01;37m\]'

    local clear='\[\033[0m\]'
    local default=${white}
    local user_color=${green}
    local dir_color=${red}
    local git_color=${yellow}
    local pyenv_color=${bold_green}

    git_prefix() {
        local git_flag=$(git rev-parse --is-inside-work-tree 2>/dev/null | grep true)

        if [[ -n "$git_flag" ]]; then
            local prefix=" on "

            echo -e "$prefix"
        fi
    }

    git_prompt() {
        local prompt
        local git_flag=$(git rev-parse --is-inside-work-tree 2>/dev/null | grep true)

        if [[ -n "$git_flag" ]]; then
            prompt="$(__git_ps1 "%s")"
            prompt="$(echo ${prompt} | sed 's/[()]//g')"
            echo -e "($prompt)"
        else
            echo -n ""
        fi
    }

    pyenv_prefix() {
        if [[ -n "$VIRTUAL_ENV" ]]; then
            local prefix=" via "

            echo -e "$prefix"
        fi
    }

    pyenv_prompt() {
        local venv
        if [[ -n "$VIRTUAL_ENV" ]]; then
            local venv=$(python --version | cut -d ' ' -f2)
            local venv=$(printf "%s" "venv $venv")
            echo -e "${venv}"
        else
            echo -n ""
        fi
    }

    # pyenv
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    # git
    export GIT_PS1_SHOWUPSTREAM=1
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_UNTRACKEDFILES=1
    export GIT_PS1_COMPRESSPARSESTATE=1
    unset GIT_PS1_HIDE_IF_PWD_IGNORED

    local PROMPT=''
    local RIGHT='\033[500C'

	PROMPT+="${user_color}"
    PROMPT+='\H'
	PROMPT+="${default}"
	PROMPT+=' at '

    # directory
	PROMPT+="${dir_color}"
    PROMPT+='\W'
	PROMPT+="${default}"


    # git
    PROMPT+="${default}"
    PROMPT+='$(git_prefix)'
    PROMPT+="${git_color}"
    PROMPT+='$(git_prompt)'
    PROMPT+="${default}"

    # pyenv
    PROMPT+="${default}"
    PROMPT+='$(pyenv_prefix)'
    PROMPT+="${pyenv_color}"
    PROMPT+='$(pyenv_prompt)'
    PROMPT+="${default}"

    # prompt
    PROMPT+="${default}"
    PROMPT+=' '
    PROMPT+='$'
    PROMPT+=' '


    PROMPT+="${clear}"

    PS1=$PROMPT
    export PS1
}

# Sets Default Interactive Prompt
if [ -n "$SSH_CONNECTION" ]; then
	export PS1="\u@\h: \w \$ "
else
    bash_prompt
fi

# Sets Continuation Interactive prompt
export PS2=">> "

# Sets Debug prompt
export PS4="> "

# Is executed after every command at prompt.
# sources bashrc automagically if written to,
# also prints new line for better visualization
# updates history file as well
__prompt_command__() {
    local rc="${HOME}/.dotfiles/bash/.bashrc"
    local current=$(stat -c %Y "${rc}")

    # global variable for timestamp of bashrc
    __ts__=${__ts__:-$(stat -c %Y "${rc}")}

    if [[ "$current" -gt "$__ts__" ]]; then
        if $BASH -n "${HOME}/.bashrc" >& /dev/null; then
            source "${HOME}/.bashrc"
        else
            printf "Error sourcing bashrc!\n" >&2
        fi
        __ts__=$(stat -c %Y "${rc}")
    fi


    # history -a; history -w; history -c; history -r
    history -a
    printf "\n"
}
export PROMPT_COMMAND='__prompt_command__'

# Path
# local/bin important for packages such as lsps, nodejs, python and npm
PATH=$PATH:${HOME}/.local/bin/

# personal binaries and scripts
PATH=$PATH:${HOME}/.bin

# lua
if command -v lua &>/dev/null; then
    export LUA_PATH=";;$HOME/Documents/programs/debugger.lua/?.lua"
    PATH=$PATH:${HOME}/.luarocks/bin/
    if [ -d ${HOME}/Documents/programs/lua-language-server ]; then
        PATH=$PATH:${HOME}/Documents/programs/lua-language-server/bin
    fi
fi

# java
if command -v java &>/dev/null; then
    export JAVA_HOME="/usr/lib/jvm/java-18-openjdk/"
fi

# ruby
if command -v ruby &>/dev/null; then
    export GEM_HOME="$HOME/.gems"
    PATH=$PATH:${HOME}/.local/gem/ruby/3.0.0/bin
    PATH=":$PATH:${HOME}/.gems/bin"
fi

# go
if command -v go &>/dev/null; then
    export GOPATH="$HOME/.go"
    PATH=$PATH:${GOPATH}/bin
fi

# haskell/cabal
if command -v ghc &>/dev/null; then
    export CABAL_PATH="$HOME/.cabal"
    PATH=$PATH:${CABAL_PATH}/bin
fi

# rust
PATH=$PATH:${HOME}/.cargo/bin

# js/node/npm
if command -v npm &>/dev/null; then
    export NPM_CONFIG_PREFIX="${HOME}/.node_modules"
    PATH=$PATH:"${HOME}/.node_modules"
fi

export PATH

# History
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=
export HISTFILESIZE=
HISTCONTROL=ignoreboth:ignoredups:ignorespace:erasedups

shopt -s histappend     # append to the history file, dont overwrite
shopt -s autocd         # type directly dir name to cd
shopt -u cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control
shopt -s dotglob        # includes file names beginning with a '.' in the
                        # results of path name globbing.

# Aliases
alias e="vim"
alias v="nvim"

# bat
if command -v bat &>/dev/null || command -v batcat &>/dev/null; then
    alias bat="batcat"
    alias cat="bat -p"
fi

# fd
if command -v fd &>/dev/null || command -v fdfind &>/dev/null; then
    alias fd="fdfind"
fi

# fetch
if command -v curl &>/dev/null; then
    alias pfetch="curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh"
fi

# xclip
if command -v xclip &>/dev/null; then
    alias clip="xclip -i -sel clip"
fi

# screenshots
if command -v maim &>/dev/null; then
    alias screenshot="maim -u -g 1920x1080+0+0 ~/Downloads/screen.png"
fi

# flatpak
if command -v flatpak &>/dev/null; then
    alias spotify="flatpak run com.spotify.Client"
fi

alias ..="cd .."
alias ...="cd ../.."

alias l="ls --color=auto --group-directories-first"
alias ls="ls --color=auto --group-directories-first"
alias sl="ls --color=auto --group-directories-first"
alias la="ls -a --color=auto --group-directories-first"
alias ll="ls -l --color=auto --group-directories-first"

alias mv="mv -i"
alias cp="cp -i"

alias less='less -R'
alias diff="diff --color=auto"

alias grep='grep --colour=always'
alias egrep='egrep --colour=always'
alias fgrep='fgrep --colour=always'

alias gupd="git add --all && git commit -m 'Update' && git push origin"
alias grd="git add README.md && git commit -m 'Updated README' && git push origin"
alias ggi="git add .gitignore && git commit -m 'Updated gitignore' && git push origin"
alias ggo="git add --all && git commit -m"
alias gs="git status"
alias ga="git add"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gcp="git cherry-pick"
alias gm="git commit -m"
alias gmm="git commit"
alias gmg="git merge"
alias gl="git log"
alias gpo="git push origin"
alias gada="git add --all"
alias gd="git diff --color=always"
alias gba="git branch --all"
alias gbd="git branch -d"
alias gbD="git push --delete origin"
alias greset="git reset --hard"

# Exports
if command -v evince &>/dev/null; then
    export READER='evince'
else
    unset READER
fi

export WM='awesome'
export VISUAL='nvim'
export EDITOR="nvim"
export GIT_EDITOR='nvim'
export DIFFPROG='nvim'
export PAGER='less'
export BROWSER='firefox'
export TERMINAL='alacritty'

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

export TERM='xterm-256color'
export BAT_THEME='ansi'
export PYLINTHOME="${XDG_DATA_HOME}/pylint"
export QT_QPA_PLATFORMTHEME='qt5ct'
export QT_STYLE_OVERRIDE='kvantum-dark'
export IPYTHONDIR="$HOME/.config/ipython/"
export CARGO_HOME="$HOME/.cargo/"
export INPUTRC="$HOME/.inputrc"
export XINITRC="$HOME/.config/X11/xinitrc"
export LESSHISTFILE=-
export WINIT_HIDPI_FACTOR=1
export WINIT_X11_SCALE_FACTOR=1
export _JAVA_AWT_WM_NONREPARENTING=1

if command -v fd &>/dev/null && \
   command -v fzf &>/dev/null; then
  export FZF_DEFAULT_COMMAND="\
  fd --follow --hidden --type f --exclude .git \
                                --exclude VMs \
                                --exclude .cache \
                                --exclude .icons \
                                --exclude .local \
                                --exclude Programs \
                                --exclude snap \
                                --exclude quicklisp \
                                --exclude Music"

  export FZF_ALT_C_COMMAND="\
  fd --follow --hidden --type d --exclude .git \
                                --exclude VMs \
                                --exclude .cache \
                                --exclude .icons \
                                --exclude .local \
                                --exclude Programs \
                                --exclude snap \
                                --exclude quicklisp \
                                --exclude Music"

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

unset  GIT_CONFIG

# Functions
cd() {
  if [ -n "$1" ]; then
	  builtin cd "$@" && ls -a --color=auto --group-directories-first
  else
	  builtin cd ~ && ls -a --color=auto --group-directories-first
  fi
}

if command -v exa &>/dev/null; then
    function ls() {
        exa "$@"
    }

    if ! command -v exa &>/dev/null; then
        alias tree="exa --tree"
    fi
fi

man() {
    # colored man pages
	env \
	  LESS_TERMCAP_mb=$(tput bold; tput setaf 6) \
	  LESS_TERMCAP_md=$(tput bold; tput setaf 6) \
	  LESS_TERMCAP_me=$(tput sgr0) \
	  LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
	  LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
	  LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 4) \
	  LESS_TERMCAP_mr=$(tput rev) \
	  LESS_TERMCAP_mh=$(tput dim) \
	  LESS_TERMCAP_ZN=$(tput ssubm) \
	  LESS_TERMCAP_ZV=$(tput rsubm) \
	  LESS_TERMCAP_ZO=$(tput ssupm) \
	  LESS_TERMCAP_ZW=$(tput rsupm) \
	man "$@"
}

# decompress file
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tar.xz)    tar xf $1      ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.xz)        unxz $1        ;;
      *)           echo "Don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

inspect() {
    local f=$1
    local d=${f}__
    mkdir ${d}
    mv ${f} ${d}
    pushd ${d}
        extract ${f}
    popd
}

if command -v fzf &>/dev/null; then
    ptmux(){
        local name=$(tmux list-sessions -F '#S' | fzf)
        [ -n "$name" ] && tmux attach-session -t $name
    }

    pgit() {
        local repo=$(curl -s "https://api.github.com/users/duclos-cavalcanti/repos" | 
                     grep -o --color=never 'git@[^"]*' | 
                     cut -d '/' -f2 | 
                     cut -d '.' -f1 | 
                     fzf)
        [ -n "$repo" ] && git clone https://github.com/duclos-cavalcanti/${repo}
    }

    # ALT-G: "\eg"
    # CTL-G: "\C-g"
    bind -m emacs-standard -x '"\C-g": pgit'
fi

. "$HOME/.cargo/env"
