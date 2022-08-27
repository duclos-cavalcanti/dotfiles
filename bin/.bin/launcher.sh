#!/bin/bash
#
# Creates a tmux session depending on the command line arguments given.

templ=$1
templates="dotfiles\nduclos\ntemplates"

usage() {
  # hacky af
  local formatted_templates=$(
        echo ${templates} |
        sed 's/\\n/\\n\\t/g')

  echo -e "
USAGE:
syntax: ./tmux-session.sh <template>

launcher.sh has the optional template arg:
  * if it is not passed on, it is assumed to be interactive
  * possible templates: \n\t${formatted_templates}"
}

createSession() {
  local session window dir
  session=$1
  window=$2
  dir=$3

  tmux has-session -t $1 > /dev/null 2>&1
  if [ $? != 0 ]; then
    tmux new-session -s $session -c $dir -d -n $window
  else
    # interactive mode
    if [ -z "$templ" ]; then
        tmux attach -t $session
    # non-interactive mode
    else
        exit 0
    fi
  fi
}

attachSession() {
  local session
  session=$1

  tmux has-session -t $1 > /dev/null 2>&1
  if [ $? = 0 ]; then
    tmux attach -t $session
  else
    exit 1
  fi
}

obtainSessions() {
  local sessions existing_sessions
  existing_sessions=$(tmux list-sessions -F '#S')
  for s in ${existing_sessions}; do
    sessions+="${s}\n"
  done

  printf "%s\n" "$sessions"
}

createWindow() {
  local session window dir
  session=$1
  window=$2
  dir=$3

  hasWindow=$(tmux list-windows -t $session | grep "$window")

  if [ -z "$hasWindow" ]; then
    tmux neww -t ${session}: -n $window -c $dir -d
  fi
}

runWindow(){
  local session window
  session=$1
  window=$2

  shift
  shift

  tmux has-session -t $session > /dev/null 2>&1
  if [ $? = 0 ]; then
    hasWindow=$(tmux list-windows -t $session -F '#W' | grep "$window")
    if [ -n "$hasWindow" ]; then
      tmux select-window -t ${session}:${window}
      tmux send-keys -t ${session}:${window} "$@" "C-m" "C-l"
    else
      exit 1
    fi
  else
    exit 1
  fi
}

selectWindow() {
  local session window
  session=$1
  window=$2

  shift
  shift

  tmux has-session -t $session > /dev/null 2>&1
  if [ $? = 0 ]; then
    hasWindow=$(tmux list-windows -t $session -F '#W' | grep "$window")
    if [ -n "$hasWindow" ]; then
      tmux select-window -t ${session}:${window}
    else
      exit 1
    fi
  else
    exit 1
  fi
}

launchSession() {
    local project="$1"
    local dir session
    case "$project" in
    "dotfiles")
        session=dotfiles
        dir="$HOME/.dotfiles/"

        createSession $session readme $dir
        createWindow $session awesome
        createWindow $session nvim
        createWindow $session rc
        createWindow $session term
        createWindow $session bash $dir
        createWindow $session mgr $dir
        createWindow $session mgr-git $dir

        runWindow $session readme "cd ~/.dotfiles && nvim README.md"
        runWindow $session rc "nvim ~/.bashrc"
        runWindow $session awesome "cd ~/.config/awesome/ && nvim rc.lua"
        runWindow $session nvim "cd ~/.config/nvim && nvim init.lua"
        runWindow $session bash "cd ~/.dotfiles && ll"
        runWindow $session term "cd ~/.config/alacritty && nvim alacritty.yml"
        runWindow $session mgr "cd ~/.dotfiles-mgr/ && nvim install.sh"
        runWindow $session mgr-git "cd ~/.dotfiles-mgr/ && ll"

        selectWindow $session awesome
        ;;

    "duclos")
        session=duclos-cavalcanti
        base="$HOME/Documents/projects/personal"
        web="duclos-cavalcanti.github.io"
        readme="duclos-cavalcanti"
        cv="curriculum-vitae"

        createSession $session config ${base}
        createWindow $session pages ${base}
        createWindow $session build ${base}
        createWindow $session cv ${base}
        createWindow $session cv-build ${base}
        createWindow $session readme-github ${base}

        runWindow $session config "cd ${web} && nvim _config.yml"
        runWindow $session pages "cd ${web} && nvim _pages/about.md"
        runWindow $session build "cd ${web}"
        runWindow $session cv "cd ${cv} && nvim ."
        runWindow $session cv-build "cd ${cv}"
        runWindow $session readme-github "cd ${readme} && nvim README.md"

        selectWindow $session config
        ;;

    "templates")
        session=templates
        base="~/Documents/projects/templates/"

        createSession $session readme ${base}
        createWindow $session bash ${base}

        runWindow $session readme "nvim README.md"
        runWindow $session bash "ll"

        selectWindow $session readme
        ;;

    *)
      usage
      exit 1
      ;;

  esac
}

getDirectories() {
  local dirs=""
  for c in $(ls); do
    if [ -d $c ]; then
      dirs+="$c\n"
    fi
  done

  dirs+="$(basename $(pwd))"
  dirs+="\n"

  printf "%s\n" "$dirs"
}

main() {
    # interactive mode
    if [ -z "$templ" ]; then
        local project dirs
        for c in $(ls); do
          if [ -d $c ]; then
            dirs+="$c\n"
          fi
        done
        dirs+="$(basename $(pwd))"

        project=$(serve --options "${templates}")
        if [ -n "$project" ]; then
            launchSession $project
        fi

    # non-interactive mode
    else
        launchSession $templ
    fi
}

main "$@"
