#!/bin/bash
#
# simple restow script

target=$1

usage() {
  echo "USAGE:
    syntax: ./restow.sh <target>

    restow.sh has:
    1) the following targets:
      * any given directory in the dotfiles folder
      "
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

unstow="stow -Dvt"
restow="stow -Svt"

pushd ~/.dotfiles
if [ -d $target ]; then
    echo "Uninstall/Unstow ${target}..."
    $unstow ~ $target

    sleep 1.5s

    echo "Install/(Re)stow ${target}..."
    $restow ~ $target
    popd
    exit 0
else
    echo "${target} isn't a directory"
    popd
    usage
    exit 1
fi
