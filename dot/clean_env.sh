#!/bin/bash
#
# Personal Stow script to clean current environement.

pushd $DOTFILES
for folder in $(echo $STOWFOLDERS | sed "s/,/ /g"); do
  echo "Removing $folder"
  stow -Dt ~ $folder
done
popd
