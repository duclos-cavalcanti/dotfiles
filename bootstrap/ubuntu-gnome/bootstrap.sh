#!/bin/bash

LOG_FILE=log.txt
FILESYSTEM=(
"${HOME}/Desktop"
"${HOME}/Documents"
"${HOME}/Downloads"
"${HOME}/Music"
"${HOME}/Media"
"${HOME}/Pictures"
"${HOME}/Videos"
"${HOME}/.config"
"${HOME}/.bin"
"${HOME}/Documents/programs"
"${HOME}/Documents/clones"
"${HOME}/Documents/vms"
"${HOME}/Documents/work"
"${HOME}/Documents/stuff"
"${HOME}/Documents/stuff/personal"
"${HOME}/Documents/stuff/ai"
"${HOME}/Documents/stuff/dsa"
"${HOME}/Documents/stuff/hw"
"${HOME}/Documents/stuff/embedded"
"${HOME}/Documents/stuff/gists"
"${HOME}/Documents/stuff/c"
"${HOME}/Documents/stuff/rust"
"${HOME}/Documents/stuff/lua"
"${HOME}/Documents/stuff/scripts"
)

DE_PACKAGES=(
gnome-session
gnome-tweaks
virtualbox
virtualbox-guest-additions-iso
nautilus
gedit
evolution
evince
gnome-calendar
gnome-weather
gnome-color-manager
gnome-disk-utility
gnome-screensaver
galculator
gimp
gcolor3
baobab
eog
totem
cheese
mate-themes
ubuntu-mate-themes
fonts-ubuntu
)

DEV_PACKAGES=(
unzip
build-essential
curl
stow
wget
python3-pip
golang
npm
fzf
fd-find
ripgrep
bat
exa
tree
cmake
clangd
gcc-arm-linux-gnueabi
gdb
cppcheck
doxygen
lcov
valgrind
lua5.1
lua5.1-doc
picocom
jq
maim
ffmpeg
pandoc
)

SNAP_PACKAGES=(
spotify
)

SERVICES=(
docker
)

# debugging
set -e

i=0
step() {
    title="$1"
    number=$((++i))
    printf \
        "+++++++++++++++> ${number}: ${title}\n" | \
        tee -a ${LOG_FILE}
}

substep() {
    title="$1"
    printf \
        "+++> ${title}\n" | \
        tee -a ${LOG_FILE}
}

setup() {
    printf "LOG:\n" > ${LOG_FILE}
}

check() {
    if command -v ${1} &>/dev/null; then
        return 1
    else
        return 0
    fi
}

filesystem() {
    step "Filesystem"
    {
        for p in ${FILESYSTEM[@]}; do
            if ! [ -d $p ]; then
                printf "Creating $p!\n"
                mkdir -p $p
            else
                printf "$p already exists!\n"
            fi
        done
    } &>> ${LOG_FILE}
}

installation() {
    step "Packages"
    local core_packages=""
    local dev_packages=""
    local total_packages=""

    for p in ${DEV_PACKAGES[@]}; do
        total_packages+="${p} "
    done


    if [ -z $XDG_CURRENT_DESKTOP ]; then 
        for p in ${DE_PACKAGES[@]}; do
            total_packages+="${p} "
        done
    else
        printf "%s\n" "${XDG_CURRENT_DESKTOP} already running!"
        printf "%s\n" "If you wish to still install gnome, run: sudo apt install ${DE}"
        printf "\n\n"
    fi

    substep "Installing Packages..."
    {
        printf "Total Packages: ${total_packages}"
        sudo apt-get update
        sudo apt-get install -y ${total_packages}

        # yq
        sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
        sudo chmod a+x /usr/local/bin/yq
    } &>> ${LOG_FILE}

    substep "Installing Snap and Flatpak Packages..."
    {
        if $(check snap); then
            for p in "${SNAP_PACKAGES[@]}"; do
                [ -z "$(ls -l /snap/bin | grep -o ${p})" ] && sudo snap install ${p}
            done
        else
            printf "Snap isn't installed? Skipping snap...\n"
        fi

        sudo apt install -y flatpak
    } &>> ${LOG_FILE}

    substep "Installing Browser (Firefox)..."
    {
        if $(check firefox); then
            sudo add-apt-repository ppa:mozillateam/ppa -y

            printf '\nPackage: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001\n' | \
                sudo tee /etc/apt/preferences.d/mozilla-firefox

            printf 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";\n' | \
                sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

            sudo apt install -y firefox
        fi
    } &>> ${LOG_FILE}

    substep "Installing Terminal (Wezterm)..."
    {
        # Wezterm
        pushd ~/Documents/clones/
            curl -LO curl -LO https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.deb
            sudo apt install -y ./wezterm-nightly.Ubuntu22.04.deb
        popd
    } &>> ${LOG_FILE}

    substep "Installing Editor(Neovim)..."
    {
        sudo apt-get install ninja-build gettext libtool-bin cmake g++ pkg-config unzip curl
        pushd ~/Documents/programs
            git clone https://github.com/neovim/neovim.git
            pushd neovim
                git checkout stable
                make CMAKE_BUILD_TYPE=Release
                sudo make install
                # sudo cmake --build build/ --target uninstall
            popd
        popd
        sudo apt remove ninja-build gettext libtool-bin pkg-config
    } &>> ${LOG_FILE}

    substep "Installing Docker..."
    {
        sudo apt install -y ca-certificates \
                            curl \
                            gnupg \
                            lsb-release

        sudo mkdir -m 0755 -p /etc/apt/keyrings
        if ! [ -f /etc/apt/keyrings/docker.gpg ]; then
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        fi

        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo apt-get update
        sudo apt install -y docker-ce \
                            docker-ce-cli \
                            containerd.io \
                            docker-buildx-plugin \
                            docker-compose-plugin
    } &>> ${LOG_FILE}

    substep "Installing Python Packages..."
    {
        if $(check pip); then
            pip install compiledb pyright ipython ipdb pyls
            pip install euporie ipykernel
        else
            printf "Pip isn't installed? Skipping Python...\n"
        fi
    } &>> ${LOG_FILE}

    substep "Installing Rust and Rust Packages..."
    {
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        PATH=$PATH:${HOME}/.cargo/bin
        export PATH

        if $(check rustup); then
            rustup update stable
            rustup component add rust-src rust-analyzer

            cargo install gitui
        else
            printf "Rustup isn't installed? Skipping Rust...\n"
        fi
    } &>> ${LOG_FILE}

    substep "Installing Go Packages..."
    {
        if $(check go); then
            export GOPATH="$HOME/.go"
            [ -d go ] && mv go $HOME/.go
            go install golang.org/x/tools/gopls@latest
            go install github.com/charmbracelet/glow@latest
        else
            printf "Go isn't installed? Skipping Go...\n"
        fi
    } &>> ${LOG_FILE}

    substep "Installing Npm Packages..."
    {
        if $(check npm); then
            sudo npm i -g bash-language-server
        else
            printf "Npm isn't installed? Skipping Npm...\n"
        fi
    } &>> ${LOG_FILE}

    substep "Installing Lua Packages..."
    {
        pushd ~/Documents/programs
            git clone https://github.com/LuaLS/lua-language-server
            cd lua-language-server
            ./make.sh
        popd
    } &>> ${LOG_FILE}

    substep "Installing Wine and Wine-Related Packages..."
    {
        sudo dpkg --add-architecture i386 && sudo apt-get update
        sudo apt-get install wine wine32 wine32-preloader 
    } &>> ${LOG_FILE}
}

services() {
    step "Services"
    {
        for s in ${SERVICES[@]}; do
            st=$(service --status-all | grep $s)
            if [ -n $(grep -o '\[ - \]' <<< ${st}) ]; then
                sudo service $s start
            else
                printf "Service ${s} is already running!"
            fi
        done
    } &>> ${LOG_FILE}
}

configuration() {
    step "Configuration/Dotfiles"
    {
        pushd ${HOME}
            local GITHUB="https://github.com/duclos-cavalcanti"
            if ! [ -d .dotfiles ]; then
                git clone "${GITHUB}/dotfiles.git" .dotfiles
                if [ $? -eq 0 ]; then
                    pushd .dotfiles
                        ./install.sh -s
                    popd
                else
                    printf "Dotfiles pull down hasnt worked!\n"
                    exit -1
                fi
            else
                printf "dotfiles aleady installed!\n"
            fi
        popd
    } &>> ${LOG_FILE}
}

main() {
    printf "
     _______________________________
    |  ___________________________  |
    | |      Automated Ubuntu     | |
    | |         Installer         | |
    | |___________________________| |
    |_______________________________|

    Welcome!
    \n"

    setup
    filesystem
    installation
    services
    configuration

    printf "
     _______________________
    |  ___________________  |
    | | Installation Done | |
    | |___________________| |
    |_______________________|
    \n"
}

main "$@"
