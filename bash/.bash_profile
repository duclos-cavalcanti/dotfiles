#
#
# ~/.bash_profile

# Load my configs
[ -f "$HOME"/.bashrc ] && . "$HOME"/.bashrc

# Autostart X 
if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    select name in "Herbstluftwm" "tty"; do
      if [ "$name" == "Herbstluftwm" ]; then
        if [ -f $HOME/.config/X11/xinitrc ]; then
          echo "Logging into herbstluftwm"
          startx -config ~/.config/X11/xinitrc
        else
          echo "xinitrc not found"
        fi
      elif [ "$name" == "tty" ]; then
        echo "Remaining in tty"
        break
      else
        echo "No valid option chosen"
        break
      fi
    done
fi


