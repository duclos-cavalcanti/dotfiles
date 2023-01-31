#!/bin/bash

dir=$(basename $(pwd))
name=$1
base="./themes/Xresources"
theme="./themes/${name}.X"

if ! [[ "$dir" == ".dotfiles" ]]; then 
    printf "%s\n" "This directory is NOT .dotfiles"
    exit 1 
fi

if ! [ -f ./themes/${name}.X ]; then 
    printf "%s\n" "File ${name}.X doesn't exist!"
    exit 1 
fi

cat ${theme} > $HOME/.dotfiles/home/.Xresources
cat ${base} >> $HOME/.dotfiles/home/.Xresources
xrdb -merge ~/.Xresources

