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
        echo -e "\n"
      else
        echo "No Valid option was chosen, remaining in tty"
      fi
    done
fi


