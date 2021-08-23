#!/bin/bash
#
# Personal Stow script of my dotiles onto a new machine.

DOTFILES=$HOME/Documents/dotfiles

STOW_FOLDERS='alacritty\n'
STOW_FOLDERS+='bash\n'
STOW_FOLDERS+='dunst\n'
STOW_FOLDERS+='herbstluftwm\n'
STOW_FOLDERS+='langs\n'
STOW_FOLDERS+='lynx\n'
STOW_FOLDERS+='mpd\n'
STOW_FOLDERS+='mutt\n'
STOW_FOLDERS+='ncmpcpp\n'
STOW_FOLDERS+='newsboat\n'
STOW_FOLDERS+='picom\n'
STOW_FOLDERS+='rofi\n'
STOW_FOLDERS+='scripts\n'
STOW_FOLDERS+='tmux\n'
STOW_FOLDERS+='vim\n'
STOW_FOLDERS+='X11\n'
STOW_FOLDERS+='zathura\n'

pushd $DOTFILES
for folder in $(echo -e $STOW_FOLDERS); do
  if [ -d $folder ]; then
    stow -Dt  ~ $folder
    stow -Svt ~ $folder
  fi
done
popd
