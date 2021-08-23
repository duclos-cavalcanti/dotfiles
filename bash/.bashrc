#______  ___   _____ _   _ 
#| ___ \/ _ \ /  ___| | | |
#| |_/ / /_\ \\ `--.| |_| |
#| ___ \  _  | `--. \  _  |
#| |_/ / | | |/\__/ / | | |
#\____/\_| |_/\____/\_| |_/
#                          

# If not running interactively return
case $- in
  *i*) ;;
    *) return
esac

# Sourcing bash's basic completion
if [ -r /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# Sourcing fzf keybindings
if [ -d /usr/share/fzf ]; then
  . /usr/share/fzf/key-bindings.bash
  . /usr/share/fzf/completion.bash
fi

# Prompts
# Sets Default Interactive Prompt
if [ -n "$SSH_CONNECTION" ]; then
	export PS1="\u@\h: \w \$ "
else
  # Sets custom Interactive Prompt
  if [[ -d $HOME/.config/bash/ ]]; then
    . $HOME/.config/bash/promptrc
    bash_prompt

  # Sets simple Interactive Prompt
  else
	  PS1='\[\033[01;31m\]\W'
    PS1+="\[\033[01;34m\] \$\[\033[00m\] "
    export PS1
  fi
fi

# Sets Continuation Interactive prompt
export PS2=">> "

# Sets Debug prompt
export PS4="> "

# Is executed after every command at prompt.
# Adds extra line and updates history.
export PROMPT_COMMAND='echo ""; history -a'

# Path
PATH=$PATH:${HOME}/.local/bin/:${HOME}/.bin
export PATH

# History
export HISTFILE='/home/duclos/.config/bash/hist/history'

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

shopt -s histappend     # append to the history file, dont overwrite
shopt -s autocd         # type directly dir name to cd
shopt -u cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control
shopt -s dotglob        # includes file names beginning with a '.' in the 
                        # results of path name globbing.

HISTSIZE=100000
HISTFILESIZE=20000

# Aliases
. $HOME/.config/bash/aliasrc

# Exports
. $HOME/.config/bash/exportsrc

# Functions
# cd and list directories
function cd() {
  if [ -n "$1" ]; then
	  builtin cd "$@" && ls -a --color=auto --group-directories-first
  else
	  builtin cd ~ && ls -a --color=auto --group-directories-first
  fi
}

if command -v exa &>/dev/null; then
  function ls() {
    exa $@
  }
fi

# colored man pages
function man() {
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

function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tar.xz)    tar xf $1     ;;
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
