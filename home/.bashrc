# bash
# If not running interactively return
case $- in
  *i*) ;;
    *) return
esac

# bash basic completion
if [ -r /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# git basic completion
if [ -r /usr/share/git/completion/ ]; then
  . /usr/share/git/completion/git-completion.bash
fi

# git prompt
if [ -r /usr/share/git/completion/ ]; then # arch
    . /usr/share/git/completion/git-prompt.sh
elif [ -r /etc/bash_completion.d/ ]; then # ubuntu
    . /etc/bash_completion.d/git-prompt
fi

# fzf bindings and completions
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

    local clear='\[\033[0m\]'

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
            prompt="$(__git_ps1 )"
            prompt="$(echo ${prompt} | sed 's/[()]//g')"
            echo -e "($prompt)"
        else
            echo -n ""
        fi
    }

    exit_prompt() {
        local ret=$__ret__
        local width=$((COLUMNS - 4))
        local restore="\[\e[u\]"
        echo -n "\e[${width}C[${ret}]${restore}"
    }

    export VIRTUAL_ENV_DISABLE_PROMPT=0
    export GIT_PS1_SHOWUPSTREAM=1
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_UNTRACKEDFILES=1
    export GIT_PS1_COMPRESSPARSESTATE=1
    unset GIT_PS1_HIDE_IF_PWD_IGNORED

    local PROMPT=''

	PROMPT+="\[\033[00;31m\]"
    PROMPT+='\W'

	PROMPT+="\[\033[00;37m\]"
    PROMPT+='$(git_prefix)'

	PROMPT+="\[\033[00;32m\]"
    PROMPT+='$(git_prompt)'
    PROMPT+="${clear}"

    # save cursor
    # PROMPT+="\[\033[s\]"

    # exit code to the right
    # PROMPT+='\e[$((COLUMNS - 4))C[$__ret__]'

    # restore cursor
    # PROMPT+='\[\033[u\]'

	PROMPT+="\[\033[00;37m\]"
    PROMPT+=' [$__ret__]'
    PROMPT+="${clear}"
    PROMPT+=' \$ '
    PROMPT+="${clear}"

    PS1=$PROMPT
    export PS1
}

# prompt
if [ -n "$SSH_CONNECTION" ]; then
	export PS1="\u@\h: \w \$ "
else
    bash_prompt
fi

# interactive prompt
export PS2=">> "

# debug prompt
export PS4="> "

# Executed after every command at prompt.
# Sources bashrc automagically if written to.
__ret__=0
__prompt_command__() {
    __ret__=$?
    local rc="${HOME}/.bashrc"
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
    # PKG_CONFIG_PATH="$HOME/.go/pkg"
    # PKG_CONFIG_PATH="$HOME/.go/pkg/mod/github.com/":${PKG_CONFIG_PATH}
    # export PKG_CONFIG_PATH
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
    export N_PREFIX="${HOME}/.n"
    export NODE="${HOME}/.n/bin/node"
    PATH="${HOME}/.n/bin/":$PATH
    PATH=$PATH:"${HOME}/.node_modules"
    PATH=$PATH:"${HOME}/.node_modules/bin"
fi

export PATH

# History
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoreboth:ignoredups:ignorespace:erasedups

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

# xclip
if command -v xclip &>/dev/null; then
    alias clip="xclip -i -sel clip"
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
alias gi="git add .gitignore && git commit -m 'Updated gitignore' && git push origin"
alias gmk="git add Makefile && git commit -m 'Updated Makefile' && git push origin"
alias gada="git add --all && git commit"
alias g="git status"
alias gunchange="git update-index --assume-unchanged"
alias ga="git add"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gm="git commit"
alias gmm="git commit -m"
alias gl="git log"
alias gpo="git push origin"
alias gd="git diff --color=always"
alias gdd="git diff HEAD~1 HEAD"
alias gba="git branch --all"
alias gbd="git branch -d"
alias gbD="git push --delete origin"
alias greset="git reset --hard"
alias greb="git rebase -i --root"

export VISUAL='nvim'
export EDITOR="nvim"
export GIT_EDITOR='nvim'
export DIFFPROG='nvim'
export PAGER='less'

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

export TMUXP_CONFIGDIR="$HOME/.dotfiles/sessions"

export TERM='tmux-256color'
export BAT_THEME='ansi'
export QT_QPA_PLATFORMTHEME='qt5ct'
export QT_STYLE_OVERRIDE='kvantum-dark'
export PYLINTHOME="${XDG_DATA_HOME}/pylint"
export IPYTHONDIR="$HOME/.config/ipython/"
export CARGO_HOME="$HOME/.cargo/"
export INPUTRC="$HOME/.inputrc"
export XINITRC="$HOME/.xinitrc"
export LESSHISTFILE=-
export WINIT_HIDPI_FACTOR=1
export WINIT_X11_SCALE_FACTOR=1

export DOWNLOAD_KEYSERVER="hkp://keyserver.ubuntu.com"

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

if command -v fzf &>/dev/null; then
    ptmux(){
        local name=$(tmux list-sessions -F '#S' | fzf --height 40% --reverse)
        [ -n "$name" ] && tmux attach-session -t $name
    }

    ptemplates() {
        local path="/home/duclos/Documents/stuff/templates"
        if [ ! -d ${path} ]; then 
            pushd "$HOME/Downloads" &>/dev/null
            [ ! -d ${templates} ] && git clone https://github.com/duclos-cavalcanti/templates
            popd &>/dev/null
            path="$HOME/Downloads/templates"
        fi

        local dir=$(/usr/bin/ls -1 -d ${path}/* | xargs -I {} basename {} | fzf --height 40% --reverse)
        [ -z "$dir" ] && exit 0
        
        cp -r ${path}/${dir} ./TEMPLATE-${dir}
    }

    pgit() {
        local repo=$(curl -s "https://api.github.com/users/duclos-cavalcanti/repos" | 
                     grep -o --color=never 'git@[^"]*' | 
                     cut -d '/' -f2 | 
                     cut -d '.' -f1 | 
                     fzf --height 40% --reverse)

        if command -v gh &>/dev/null; then
            [ -n "$repo" ] && gh repo clone duclos-cavalcanti/${repo}
        else
            [ -n "$repo" ] && git clone https://github.com/duclos-cavalcanti/${repo}
        fi
    }

    # ALT-G: "\eg"
    # CTL-G: "\C-g"
    bind -m emacs-standard -x '"\C-o": ptmux'
    bind -m emacs-standard -x '"\C-g": pgit'
    bind -m emacs-standard -x '"\C-t": ptemplates'
fi
