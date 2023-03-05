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

# Sourcing fzf keybindings
if [ -d /usr/share/fzf ]; then
  . /usr/share/fzf/key-bindings.bash
  . /usr/share/fzf/completion.bash
fi

bash_prompt() {
    local __primary__="white"
    local __git_color__="bold_yellow"
    local __pyenv_color__="bold_green"

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
    local primary=$(eval "echo \$$__primary__")
    local git_color=$(eval "echo \$$__git_color__")
    local pyenv_color=$(eval "echo \$$__pyenv_color__")

    last_command_prompt() {
        local value="$?"
        printf "${value}"
    }

    git_prefix() {
        local git_flag=$(git rev-parse --is-inside-work-tree 2>/dev/null | grep true)

        if [[ -n "$git_flag" ]]; then
            local prefix="━"
            prefix+="━"
            prefix+="["

            echo -e "$prefix"
        fi
    }

    git_suffix() {
        local git_flag=$(git rev-parse --is-inside-work-tree 2>/dev/null | grep true)

        if [[ -n "$git_flag" ]]; then
            local suffix="]"

            echo -e "$suffix"
        fi
    }

    git_prompt() {
        local prompt
        local git_status
        local git_flag=$(git rev-parse --is-inside-work-tree 2>/dev/null | grep true)

        if [[ -n "$git_flag" ]]; then
            local git_status="$(__git_ps1 "%s")"
            # removes brackets
            git_status=$(echo "$git_status" | sed 's/\[//g')
            git_status=$(echo "$git_status" | sed 's/\]//g')

            prompt="${git_status}"

            echo -e "$prompt"
        else
            echo -n ""
        fi
    }

    pyenv_prefix() {
        if [[ -n "$VIRTUAL_ENV" ]]; then
            local prefix="━"
            prefix+="━"
            prefix+="["

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

    pyenv_suffix() {
        if [[ -n "$VIRTUAL_ENV" ]]; then
            local suffix="]"
            echo -e "$suffix"
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

    # first line / host
	PROMPT+="${primary}"
	PROMPT+='┏━'
	PROMPT+='['
    PROMPT+='$(last_command_prompt)'
	PROMPT+=']'

	PROMPT+="${primary}"
    PROMPT+="━"
	PROMPT+='['
	PROMPT+="${bold_red}"
    PROMPT+='\H'
	PROMPT+="${primary}"
	PROMPT+=']'

    # directory
    PROMPT+="━"
	PROMPT+='['
	PROMPT+="${bold_blue}"
    PROMPT+='\W'
	PROMPT+="${primary}"
	PROMPT+=']'

    # git
    PROMPT+="${primary}"
    PROMPT+='$(git_prefix)'
    PROMPT+="${git_color}"
    PROMPT+='$(git_prompt)'
    PROMPT+="${primary}"
    PROMPT+='$(git_suffix)'

    # pyenv
    PROMPT+="${primary}"
    PROMPT+='$(pyenv_prefix)'
    PROMPT+="${pyenv_color}"
    PROMPT+='$(pyenv_prompt)'
    PROMPT+="${primary}"
    PROMPT+='$(pyenv_suffix)'

    # jump line
    PROMPT+=$'\n'

    # second line
    PROMPT+="${primary}"
    PROMPT+='┗━━'
    PROMPT+=' '
    PROMPT+="${primary}"

    # if this is a tty
    if [ -z "$DISPLAY" ]; then
        PROMPT+='$'
        PROMPT+=' '
    else # gui
        PROMPT+='$'
        PROMPT+=' '
    fi

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

# vivado/xilinx
if [ -d "${HOME}/Programs/Xilinx" ]; then
    PATH=$PATH:${HOME}/Programs/Xilinx/Vivado/2022.1/bin
fi

# lua
if command -v lua &>/dev/null; then
    PATH=$PATH:${HOME}/.luarocks/bin/
    export LUA_PATH=";;$HOME/Documents/projects/langs/lua/debugger.lua/?.lua"
    # git clone https://github.com/slembcke/debugger.lua.git
    # mkdir .lua && git clone https://github.com/sumneko/lua-language-server.git
    # on arch the language server is available as a package!

    alias luamake=$HOME/.lua/lua-language-server/3rd/luamake/luamake
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
if command -v rustc &>/dev/null; then
    PATH=$PATH:${HOME}/.cargo/bin
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
if command -v bat &>/dev/null; then
    alias cat="bat -p"
fi

# fetch
if command -v pfetch &>/dev/null; then
    :
    # pfetch
else
    if command -v curl &>/dev/null; then
        alias pfetch="curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh"
        curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh
    fi
fi

# xclip
if command -v xclip &>/dev/null; then
    alias clip="xclip -i -sel clip"
fi

# screenshots
if command -v maim &>/dev/null; then
    alias screenshot="maim -u -g 1920x1080+1080+0 ~/Downloads/screen.png"
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

alias less='less -r'
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
if command -v zathura &>/dev/null; then
    export READER='zathura'
else
    unset READER
fi

export WM='awesome'
export VISUAL='nvim'
export EDITOR="nvim"
export GIT_EDITOR='nvim'
export DIFFPROG='nvim'
export PAGER='less'
export BROWSER='brave'
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
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export QT_QPA_PLATFORMTHEME='qt5ct'
export QT_STYLE_OVERRIDE='kvantum-dark'
export IPYTHONDIR="$HOME/.config/ipython/"
export CARGO_HOME="$HOME/.cache/cargo/"
export GNUPGHOME="$HOME/.gnupg"
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

    alias tree="exa --tree"
fi

# man pages
# MANPATH=$MANPATH:/usr/share/man/man2
# MANPATH=$MANPATH:/usr/share/man/man3
# MANPATH=$MANPATH:/usr/share/man/man3p
# export MANPATH

# updates the man page database
# mandb -u
# unset MANPATH

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
        local repo=$(curl -s "https://api.github.com/users/duclos-cavalcanti/repos" | grep -o --color=never 'git@[^"]*' | fzf)
        [ -n "$repo" ] && git clone $repo
    }

    # ALT-G: "\eg"
    # CTL-G: "\C-g"
    bind -m emacs-standard -x '"\C-g": pgit'
    bind -m emacs-standard -x '"\C-t": ptmux'
fi

