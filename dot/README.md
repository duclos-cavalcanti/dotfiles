# Table of Contents
1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Maintenance](#maintenance)

<a name="installation"/>

## 1. Installation

#### 1.1 Set Keyboard Layout
List keyboard layouts:
```sh
ls /usr/share/kbd/keymaps/**/*.map.gz
```

Load keyboard layout:

```
loadkeys us
```
Console fonts are located at `/usr/share/kbd/consolefonts/` and can be set by `setfont`.

#### 1.2 Verify Boot Mode
`ls /sys/firmware/efi/efivars/`

If directory is shown with no error, system has booted in UEFI mode.

#### 1.3 Connect to the internet
Ensure network interface is listed and enabled through `ip link`. Connection is verified
with `ping archlinux.org`.

#### 1.4 Update System Clock
```sh
# systemctl enable systemd-timesyncd
timedatectl set-ntp true
```

#### 1.5 Update Pacman
```
pacman -Syy archlinux-keyring
```

#### 1.6 Disk Partitioning
Use `lsblk` or `fdisk -l` to list available block devices. 

Optional disk partitions:

1. EFI   300MB /dev/sda1
2. Swap  8GB   /dev/sda2
3. root  32GB  /dev/sda3
4. home  --GB  /dev/sda4

The main block device can also be named sbd or nvme0n1p depending on block devices. The `mnt/boot or /mnt/efi` should be at least 160 MiB. Swap should be more than 512 MiB.


Commands for partitioning:
```sh
cfdisk --zero /dev/sda
```

Commands for formatting:
```sh
# Non-Swap Partitions
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

# Swap Partitions
mkswap /dev/sda2
```

Commands for mounting:
```sh
mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mkdir -p /mnt/home
mount /dev/sda1 /mnt/boot/efi
mount /dev/sda4 /mnt/home

swapon /dev/sda2
```
Example final partitioning:
```sh
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    1     0B  0 disk
nvme0n1     259:0    0 238.5G  0 disk
├─nvme0n1p1 259:1    0   286M  0 part /boot/efi
├─nvme0n1p2 259:2    0   7.5G  0 part
├─nvme0n1p3 259:3    0  29.8G  0 part /
└─nvme0n1p4 259:4    0 200.9G  0 part /home
```
#### 1.7 Mirrorlist 

Either edit the `mirrorlist` by hand or use `reflector`.
```sh
reflector \
--save /etc/pacman.d/mirrorlist \
--country France,Germany \
--protocol https \
--latest 5
```

#### 1.8 Install essential packages

```
pacstrap /mnt \
  base base-devel linux linux-headers linux-lts linux-lts-headers \
  linux-firmware networkmanager grub mkinitcpio efibootmgr        \
  sudo vim git stow reflector
```

#### 1.9 Generate Fstab
```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Example configuration of file:
```sh
# <file system> <dir> <type> <options> <dump> <pass>
# /dev/nvme0n1p3
UUID=b06b22f6-0a75-4f76-acf3-82017d3dc4c4	/         	ext4      	rw,relatime	0 1

# /dev/nvme0n1p1
UUID=E60D-2AA8      	/boot/efi 	vfat      	rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro	0 2

# /dev/nvme0n1p4
UUID=d3a0e96c-0671-431c-95a8-7154c6f8ca20	/home     	ext4      	rw,relatime	0 2
```

#### 1.10 Chroot into Install
Change root into the new system.

```
arch-chroot /mnt
```

#### 1.11 Time zone
```sh
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc --utc
```

#### 1.12 Localization
Edit /etc/locale.gen and uncomment `en_US.UTF-8 UTF-8` and other needed locales. Generate the locales by running:

```sh
locale-gen
```
Go to/Create `locale.conf` file and set the "LANG" variable accordingly:
```sh
# located at /etc/locale.conf

LANG=en_US.UTF-8
```

Make changes to keyboard layout persistent. Go to `/etc/vconsole.conf` and check for:
```sh
KEYMAP=us
FONT=
FONT_MAP=
```
#### 1.13 Network Configuration

Go to/Create the `hostname` file at /etc/hostname. 
```sh
# located at /etc/hostname

archthink
```

Add matching entries to `hosts`.
```sh
# located at /etc/hosts


127.0.0.1	localhost
::1	        localhost
127.0.1.1	archthink.localdomain	archthink
```

#### 1.14 Password and Host User
Set root password:
```
passwd
```

Set user and user's password:
```
useradd -m <user>
passwd <user>
```

Adding host user to groups:
```sh
usermod -aG wheel,audio,video,optical,storage duclos
```

Uncomment `%wheel ALL=(ALL)ALL`.
```sh
EDITOR=vim visudo
```
#### 1.15  Enable necessary services
```sh
systemctl enable NetworkManager
systemctl enable systemd-timesyncd
```

#### 1.16 Initramfs
```
# mkinitcpio -p linux
mkinitcpio -P
```

#### 1.17 Grub
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
```

#### 1.18 Reboot
1. `Exit` or press `Ctrl-D`.
2. Unmount with `umount -R /mnt`
3. Reboot

<a name="configuration"/>

## 2. Configuration

#### 2.1 System Packages
Hardware related packages:
```
intel-media-driver intel-ucode xf86-video-intel mesa mesa-demos 

usbutils udiskie net-tools wireless_tools blueman pulseaudio pamixer
pulseaudio-bluetooth openssh pavucontrol tlp acpi bluez bluez-utils
brightnessctl
```
X11/Xorg related packages:
```
xorg-server xorg-xinit xorg-xrdb xorg-xrandr xorg-xmodmap xorg-setxkbmap
xorg-xwininfo xorg-xprop xorg-xev xorg-xsetroot xorg-xset
xorg-fonts-100dpi xorg-fonts-75dpi
```
Core Packages
```
herbstluftwm picom dzen2 dunst firefox alacritty 
unclutter xwallpaper xclip xdotool xdo man-pages 
i3lock

neomutt notmuch offlineimap cron pass ncmpcpp mpd
mpc newsboat weechat

libre-office mousepad zathura zathura-pdf-poppler poppler
pcmanfm mpv sxiv gcolor3 gimp galculator sylpheed maim
ffmpeg imagemagick

virtualbox docker
arm-none-eabi-binutils arm-none-eabi-gcc arm-none-eabi-gdb arm-none-eabi-newlib
rust clang doxygen nano ctags
```

Theme/Look-and-Feel Packages:
```
arc-icon-theme arc-gtk-theme xcursor-themes kvantum-qt5 qt5ct lxappearance
```

Printer Packages:
```
cups cups-pdf hplip system-config-printer sane xsane
```

VPN Packages:
```
openvpn openconnect
```

Work Packages:
```
gtest lcov(AUR) dos2unix
```
#### 2.2 AUR Packages
To be able to install packages from the AUR, one has to install a AUR-helper like `paru`.

```sh
pushd "$(pwd)"

cd /opt
sudo git clone https://aur.archlinux.org/paru.git
sudo chown -R duclos:duclos ./paru
cd paru
makepkg -si

paru -S zoom    # as an example

popd
```

#### 2.3 Python Packages

```
pip install compiledb
pip install spotdl
pip install 'python-language-server[all]'
pip install git+https://github.com/pytube/pytube
# pip install --upgrade spotdl
# pip install --upgrade pytube
```

#### 2.4 Enable Newly Installed Services
```sh
sudo systemctl enable tlp
```

#### 2.5 System File structure

```sh
pushd "$(pwd)"

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

popd
```

<a name="maintenance"/>

## 3. Maintenance
