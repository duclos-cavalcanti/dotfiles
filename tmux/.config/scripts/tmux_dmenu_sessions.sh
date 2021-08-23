#!/bin/bash
#
# Dmenu wrapper menu around tmux session creation.

custom_dmenu=$CUSTOM_DMENU_PROMPT
tmux_create=${TMUX_PATH}/tmux_create_session.bash

answ=$(echo -e "CS\nFP\nESS\nMISC" | $custom_dmenu -i -p "Sessions:") 

case "$answ" in
  "CS")
    $tmux_create -cs CS
    CMD_1="st tmux attach-session -t CS"
    CMD_2="st tmux attach-session -t CS-ALT"
    $CMD_1 &
    $CMD_2 &
    ;;

  "FP")
    $tmux_create -fp FP
    CMD_1="st tmux attach-session -t FP"
    CMD_2="st tmux attach-session -t FP-ALT"
    $CMD_1 &
    $CMD_2 &
    ;;

  "ESS")
    $tmux_create -ess ESS
    CMD_1="st tmux attach-session -t ESS"
    CMD_2="st tmux attach-session -t ESS-ALT"
    $CMD_1 &
    $CMD_2 &
    ;;

  "MISC")
    $tmux_create -ex EX 
    CMD="st tmux attach-session -t EX"
    $CMD &
    ;;

*) echo "Unavailable Command."
esac
