#!/bin/bash
#
# Script to automate the most of my arch linux install.

# -- On Thinkpad --
# Shift goes to Grub
# F2 goes to BIOS
# F12 goes to Boot menu

usr=duclos
dotfiles=~/Documents/dotfiles

function install::log() {
  text=$1
  echo "LOG: ${text}..."
}

function install::preparation() {
  install::log "Loading Keys"
  loadkeys us

  install::log "Checking UEFI Mode"
  [ -n "$(ls /sys/firmware/efi/efivars)" ] && echo "UEFI mode enabled!"

  install::log "Enabling Systemd"
  systemctl enable --now systemd timesyncd

  install::log "Setting timedatectl"
  timedatectl set-ntp true
}

function install::update_packages() {
  install::log "Updating Pacman"
  pacman -Syy archlinux-keyring
}

function install::partitioning() {
  install::log "Partitioning drives"
  declare -a drives
  while read -r name _ _ _ _ _ _ var; do
    echo "$name"
  done < <(lsblk -l | tail -4)

  # cfdisk --zero /dev/sda (or sbd)
  # EFI   300MB /dev/sda1
  # Swap  8GB   /dev/sda2
  # root  32GB  /dev/sda3
  # home  --GB  /dev/sda4
  #
  # mount /dev/sda3 /mnt
  # mkdir -p /mnt/boot/efi
  # mkdir -p /mnt/home
  # mount /dev/sda1 /mnt/boot/efi
  # mount /dev/sda4 /mnt/home
}

function install::pacstrap() {
  install::log "Pacstrapping base installation"
  pacstrap /mnt \
    base base-devel linux linux-headers linux-lts linux-lts-headers \
    linux-firmware networkmanager grub mkinitcpio efibootmgr        \
    sudo vim git stow reflector
}

function install::genfstab() {
  install::log "Pacstrapping base installation"
  genfstab -U /mnt >> /mnt/etc/fstab
}

function install::chroot() {
  install::log "Chrooting"
  arch-chroot /mnt
}

function install::vconsole() {
  install::log "Vconsole"
  echo "KEYMAP=us\nFONT=\nFONT_MAP=" >> /etc/vconsole.conf
  # KEYMAP=us
  # FONT=
  # FONT_MAP=
}

function install::locale_gen() {
  install::log "Locale-gen"
  echo "Go to /etc/locale.gen and uncomment en_US.UTF-8 UTF-8."
  echo "Then run locale-gen."
  echo "Finally go to /etc/locale.conf and check if LANG=en_US.UTF-8 option."
  # en_US.UTF-8 UTF-8  
  # locale-gen
}

function install::localtime() {
  install::log "Localtime"
  ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
  # en_US.UTF-8 UTF-8  
  # locale-gen
}

function install::hwclock() {
  install::log "Hwclock"
  hwclock --systohc --utc
}

function install::machine_name() {
  install::log "Machine Name"
  select name in "archthink" "thinkpad" "archdesktop"; do
    echo "$name" >> /etc/hostname
    echo -e "127.0.0.1\t\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t\t${name}.localdomain ${name}" \
          > /etc/hosts
  done
}

function install::host_name() {
  install::log "Creating Password"
  passwd

  install::log "Host Name"
  useradd -m duclos
  passwd duclos
}

function install::groups() {
  install::log "Addings Host to groups"
  usermod -aG wheel,audio,video,optical,storage duclos

  install::log "Wheel group"
  echo "Uncomment %wheel ALL=(ALL)ALL"
  EDITOR=vim visudo
}

function install::systemctl() {
  install::log "Systemctl units"
  systemctl enable NetworkManager
  systemctl enable systemd-timesyncd
}

function install::mkinitcpio() {
  install::log "mkinitcpio"
  mkinitcpio -p linux
}

function install::grub() {
  install::log "grub"
  grub-install --target=x86_64-efi --efi-directory=/boot/efi
  grub-mkconfig -o /boot/grub/grub.cfg
}

function install::system_packages() {
  install::log "Installing Hardware packages"
  sudo pacman -S intel-media-driver intel-ucode xf86-video-intel mesa mesa-demos 

  sudo pacman -S usbutils udiskie net-tools wireless_tools blueman pulseaudio pamixer \ 
                 pulseaudio-bluetooth openssh pavucontrol tlp acpi bluez bluez-utils

  install::log "Installing X11-related packages"
  sudo pacman -S xorg-server xorg-xinit xorg-xrdb xorg-xrandr xorg-xmodmap xorg-setxkbmap \ 
                 xorg-xwininfo xorg-xprop xorg-xev xorg-xsetroot xorg-xset \ 
                 xorg-fonts-100dpi xorg-fonts-75dpi

  install::log "Installing WM/Core packages"
  sudo pacman -S herbstluftwm picom dzen2 dunst firefox alacritty \ 
                 unclutter xwallpaper xclip xdotool xdo man-pages 

  sudo pacman -S neomutt notmuch offlineimap cron pass ncmpcpp mpd \ 
                 mpc newsboat weechat

  sudo pacman -S libre-office mousepad zathura zathura-pdf-poppler poppler \ 
                 pcmanfm mpv sxiv gcolor3 gimp galculator sylpheed maim \ 
                 ffmpeg imagemagick

  sudo pacman -S virtualbox docker \ 
                 arm-none-eabi-binutils arm-none-eabi-gcc arm-none-eabi-gdb arm-none-eabi-newlib \ 
                 rust clang doxygen

  sudo pacman -S fzf tree bat exa jq rsync ripgrep

  install::log "Installing Theme/Look-and-Feel packages"
  sudo pacman -S arc-icon-theme arc-gtk-theme xcursor-themes kvantum-qt5 qt5ct lxappearance

  install::log "Installing Printer packages"
  sudo pacman -S cups cups-pdf hplip system-config-printer sane xsane
}

function install::aur_packages() {
  install::log "Installing paru"
  pushd "$(pwd)"

  cd /opt
  sudo git clone https://aur.archlinux.org/paru.git
  sudo chown -R duclos:duclos ./paru
  cd paru
  makepkg -si

  install::log "Installing aur packages"
  paru -S zoom

  popd
}

function install::python_packages() {
  install::log "Installing python packages"
  pip install grip compiledb
  pip install spotdl
  pip install ueberzug
  pip3 install git+https://github.com/pytube/pytube
  # pip install --upgrade spotdl
  # pip install --upgrade pytube
}

function install::systemd_services() {
  install::log "Enabling remaining SystemD Services"
  sudo systemctl enable tlp
}

function install::filestructure() {
  install::log "Creating base-filestructure"
  mkdir -p /home/duclos/Desktop
  mkdir -p /home/duclos/Documents
  mkdir -p /home/duclos/Documents/uni
  mkdir -p /home/duclos/Documents/work
  mkdir -p /home/duclos/Documents/tutor
  mkdir -p /home/duclos/Documents/learn
  mkdir -p /home/duclos/Documents/projects
  mkdir -p /home/duclos/Documents/personal
  mkdir -p /home/duclos/Downloads
  mkdir -p /home/duclos/Music
  mkdir -p /home/duclos/Mail
  mkdir -p /home/duclos/Pictures
  mkdir -p /home/duclos/Videos
  mkdir -p /home/duclos/VMs

  mkdir -p /home/duclos/.config
  mkdir -p /home/duclos/.bin

  cd /home/duclos/Documents
  git clone https://github.com/duclos-cavalcanti/dotfiles.git
}

function main() {
  set -x

  install::preparation
  install::update_packages
  install::partitioning
  install::pacstrap
  install::genfstab
  install::chroot

  install::vconsole
  install::locale_gen
  install::localtime
  install::hwclock
  install::machine_name
  install::host_name
  install::groups
  install::systemctl
  install::mkinitcpio
  install::grub
  
  install::log "Exit now with 'exit' and unmount with umount -R /mnt"

  install::system_packages
  install::aur_packages
  install::python_packages
  install::systemd_services
  install::filestructure

  # https://addons.mozilla.org/en-US/firefox/addon/nord123/
  # Nord theme for firefox
}
