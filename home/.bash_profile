#
#
# ~/.bash_profile

# Load my configs
[ -f "$HOME"/.bashrc ] && . "$HOME"/.bashrc

# Autostart X
if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    answer=""
    while [ -z "$answer" ]; do
        echo -n "Login Desktop [y/n]:"
        read answer
        if [ "$answer" = 'y' ]; then
            startx ~/.config/X11/xinitrc
        elif [ "$answer" = 'n' ]; then
            echo "Remaining in tty..."
            break
        else
            echo "Invalid Answer!"
            answer=""
        fi
    done
fi


. "$HOME/.cargo/env"

if [ -e /home/duclos/.nix-profile/etc/profile.d/nix.sh ]; then . /home/duclos/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
