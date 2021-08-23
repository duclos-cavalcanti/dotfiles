#!/bin/bash
#
# Creates a tmux session depending on the command line arguments given.

FP="~/Documents/work/TensorDSE/"
ESS="~/Documents/Uni/ESS/User/Embedded-Systems-SEC/"
CS="~/Documents/extra/python/Intro_to_AI/"

function createSession() {
    session=$1
    window=$2

    cmd="tmux -2 -f ~/.config/tmux/tmux.conf new-session -s $session -d -n $window"

    tmux has-session -t $1 > /dev/null 2>&1
    if [ $? != 0 ]  
    then
        eval $cmd
    else
        exit 1
    fi
}

function createWindow() {
    session=$1
    window=$2

    shift
    shift

    hasWindow=$(tmux list-windows -t $session | grep "$window")

    if [ -z "$hasWindow" ]; then
        cmd="tmux neww -t ${session}: -n $window -d"
        eval $cmd
    fi
}

function runWindow(){
    session=$1
    window=$2

    shift 
    shift

    tmux select-window -t ${session}:${window}
    
    cmd="tmux send-keys -t ${session}:${window} '$@' C-m C-l"
    eval $cmd

}

mode=$1
sess=$2

function main {
  case "$mode" in
  "-fp")
    createSession $sess MAIN 
    [ $? -eq 1 ] && exit
  
    runWindow $sess MAIN "cd $FP"
    runWindow $sess MAIN "source venv/bin/activate.fish"
    runWindow $sess MAIN "cd benchmarking/reading_tflite_model"
    runWindow $sess MAIN "vim ."
  
  
    new_sess="${sess}-ALT"
    createSession $new_sess IPY
    [ $? -eq 1 ] && exit
  
    createWindow $new_sess DBG
    createWindow $new_sess DOCKER
  
    runWindow $new_sess IPY "cd $FP"
    runWindow $new_sess IPY "source ./venv/bin/activate.fish"
    runWindow $new_sess IPY "ipython"
  
    runWindow $new_sess DBG "cd $FP"
    runWindow $new_sess DBG "source ./venv/bin/activate.fish"
  
    runWindow $new_sess DOCKER "docker start exp-docker && docker attach exp-docker"
    ;;
  
  "-ess")
    createSession $sess MAIN
    [ $? -eq 1 ] && exit
  
    createWindow $sess ALT
  
    new_sess="${sess}-ALT"
    createSession $new_sess DBG
    [ $? -eq 1 ] && exit
  
    createWindow $new_sess DBG-ALT
  
    runWindow $sess MAIN "cd $ESS"
    runWindow $sess ALT "cd $ESS"
  
    runWindow $new_sess DBG "cd $ESS"
    runWindow $new_sess DBG-ALT "cd $ESS"
    ;;
  
  "-cs")
    createSession $sess MAIN
    [ $? -eq 1 ] && exit
  
    new_sess="${sess}-ALT"
    createSession $new_sess IPY
    [ $? -eq 1 ] && exit
  
    createWindow $new_sess DBG
  
    runWindow $sess MAIN "cd ${CS}/ai50/projects/Search/tictactoe/"
    runWindow $sess MAIN "vim runner.py"
  
    runWindow $new_sess IPY "cd ${CS}"
    runWindow $new_sess IPY "source venv/bin/activate.fish"
    runWindow $new_sess IPY "ipython"
  
    runWindow $new_sess DBG "cd ${CS}"
    runWindow $new_sess DBG "source venv/bin/activate.fish"
    runWindow $new_sess DBG "cd ${CS}/ai50/projects/Search/tictactoe/"
    ;;
  
  "-ex")
    createSession $sess MAIN
    [ $? -eq 1 ] && exit
  
    runWindow $sess MAIN "cd $ESS"
    ;;
  
  *) echo "Unavailable Command."

  esac
}
