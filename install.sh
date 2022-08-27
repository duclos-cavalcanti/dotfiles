#!/bin/bash
#
# Personal Stow script of my dotiles onto a new machine.

script_=$(basename $0)

mode=$1
option=$2

usage() {
  echo "USAGE:
    syntax: ./${script_} <mode> <option>

    ${script_} has:
    1) the following modes:
      * pc:	for regular computers
      * server: for servers

    2) the following options:
      * install:  stows the dotfiles folders onto the system
      * clean: cleans the system from the stowed folders
      "
}

if [ $# -lt 2 ]; then
  usage
  exit 1
fi

if [ "$mode" = pc ]; then
  echo "Stowing in pc mode..."
elif [ "$mode" = server ]; then
  echo "Stowing in server mode..."
else
  usage
  exit 1
fi

stow=""
if [ "$option" = install ]; then
  echo "Stowing option will install dots..."
  stow="stow -Svt"
elif [ "$option" = clean ]; then
  echo "Stowing option will uninstall dots..."
  stow="stow -Dvt"
else
  usage
  exit 1
fi

DOTFILES=$(dirname "$0")

STOW_FOLDERS='bash\n'
STOW_FOLDERS+='tmux\n'

if [ "$mode" = pc ]; then
  STOW_FOLDERS+='alacritty\n'
  STOW_FOLDERS+='awesome\n'
  STOW_FOLDERS+='nvim\n'
  STOW_FOLDERS+='picom\n'
  STOW_FOLDERS+='bin\n'
  STOW_FOLDERS+='X11\n'
fi

pushd $DOTFILES

for folder in $(echo -e $STOW_FOLDERS); do
  if [ -d $folder ]; then
    $stow ~ $folder
  fi
done

popd
