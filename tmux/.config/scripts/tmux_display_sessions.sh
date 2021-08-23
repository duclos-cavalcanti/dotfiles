#!/bin/bash
#
# Displays current tmux session to stdout.

tls=$(tmux ls -F "#(session_name)")
declare -a sess_array

current_session=$1
sessions=$(tmux ls)
num_sessions=$(tmux ls | wc -l)

function hasSession {
  tmux has-session -t $1 > /dev/null 2>&1
  if [ $? != 0 ]; then
    return 1
  else
    return 0
  fi
}

function main {
  i=0
  for sess in $(tmux ls); do
    if [[ "$sess" =~ [*:] ]]; then
      sess_name=$(echo "$sess" | cut -d ':' -f1)
      hasSession $sess_name 
      [ $? == 0 ] && { sess_array[i]=$sess_name ; i=$((i+1)); }
    fi
  done
  
  i=0
  text=""
  for sess_name in ${sess_array[@]}; do
    if [ -z text ] ; then
      text="${sess_name},"
    else
      text="$text ${sess_name},"
    fi
    i=$((i+1))
  done
  echo $text
}

main

