#!/bin/bash

LOG=log.txt
SUMMARY=summary.txt

FILESYSTEM=(
"${HOME}/Desktop"
"${HOME}/Documents"
"${HOME}/Downloads"
"${HOME}/Music"
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
"${HOME}/Documents/stuff/exs"
"${HOME}/Documents/stuff/hw"
"${HOME}/Documents/stuff/embedded"
"${HOME}/Documents/stuff/gists"
"${HOME}/Documents/stuff/c"
"${HOME}/Documents/stuff/rust"
"${HOME}/Documents/stuff/lua"
"${HOME}/Documents/stuff/scripts"
)

CORE_PACKAGES=(
ubuntu-desktop
gnome-tweaks 
gnome-shell-extensions
gnome-shell-extension-manager
dconf-cli
dconf-editor
tmux
tmuxp
stow
vim
fonts-ubuntu
fonts-liberation
)

DEV_PACKAGES=(
build-essential
unzip
curl
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
ninja-build
clangd
ccls
gcc-arm-linux-gnueabi
gdb
cppcheck
doxygen
lcov
valgrind
lua5.1
lua5.1-doc
g++-12
picocom
jq
pandoc 
wkhtmltopdf
jupyter
gh
sshfs
)

DESKTOP_PACKAGES=(
evolution
ffmpeg
xclip
xserver-xephyr
)

SERVICES=(
docker
)

SNAP=(
spotify
zoom-client
slack
)

# debugging
set -e

i=0
step() {
    title="$1"
    number=$((++i))
    printf \
        "+++++++++++++++> ${number}: ${title}\n" | \
        tee -a ${LOG}
}

substep() {
    title="$1"
    printf \
        "+++> ${title}\n" | \
        tee -a ${LOG}
}

setup() {
    printf "LOG:\n" > ${LOG}
    printf "SUMMARY:\n" > ${SUMMARY}
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
        printf "%s\n" "FILESYSTEM DONE" &>> ${SUMMARY}
    } &>> ${LOG}
}

installation() {
    step "Packages"
    local core_packages=""
    local dev_packages=""
    local total_packages=""

    for p in ${DESKTOP_PACKAGES[@]} ${CORE_PACKAGES[@]} ${DEV_PACKAGES[@]}; do
        total_packages+="${p} "
    done

    substep "Installing Packages..."
    {
        printf "Total Packages: ${total_packages}"
        sudo apt-get update
        sudo apt-get install -y ${total_packages}

        printf "%s\n" "MAIN PACKAGES DONE" &>> ${SUMMARY}
    } &>> ${LOG}

    substep "Installing Snap Packages..."
    {
        for p in ${SNAP[@]}; do
            sudo snap install $p
        done
        printf "%s\n" "SNAP PACKAGES DONE" &>> ${SUMMARY}
    } &>> ${LOG}

    substep "Installing Editor(Neovim)..."
    {
        if ! command -v nvim; then
            sudo apt install -y ninja-build gettext libtool-bin cmake g++ pkg-config unzip curl
            pushd ~/Documents/programs
                git clone https://github.com/neovim/neovim.git
                pushd neovim
                    git checkout stable
                    make CMAKE_BUILD_TYPE=Release
                    sudo make install
                popd
            popd
            sudo apt remove -y ninja-build gettext libtool-bin pkg-config
            printf "%s\n" "EDITOR DONE" &>> ${SUMMARY}
        else
            printf "%s\n" "NVIM ALREADY INSTALLED - SKIP" &>> ${SUMMARY}
        fi
    } &>> ${LOG}

    substep "Installing VScode..."
    {
        if ! command -v code; then
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
            sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
            sudo sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
            sudo apt update
            sudo apt install code
        else
            printf "%s\n" "VSCODE ALREADY INSTALLED - SKIP" &>> ${SUMMARY}
        fi
    } &>> ${LOG}

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

        printf "%s\n" "DOCKER DONE" &>> ${SUMMARY}
    } &>> ${LOG}

    substep "Installing Python Packages..."
    {
        if command -v pip; then
            pip install compiledb pyright ipython ipdb pyls
            pip install euporie ipykernel
            printf "%s\n" "PYTHON DONE" &>> ${SUMMARY}
        else
            printf "%s\n" "PIP ISNT INSTALLED - SKIP" &>> ${SUMMARY}
        fi
    } &>> ${LOG}

    substep "Installing Rust and Rust Packages..."
    {
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        PATH=$PATH:${HOME}/.cargo/bin
        export PATH

        if command -v rustup; then
            rustup update stable
            rustup component add rust-src rust-analyzer

            cargo install gitui
            printf "%s\n" "RUST DONE" &>> ${SUMMARY}
        else
            printf "%s\n" "RUSTUP ISNT INSTALLED - SKIP" &>> ${SUMMARY}
        fi
    } &>> ${LOG}

    substep "Installing Go Packages..."
    {
        if command -v go; then
            export GOPATH="$HOME/.go"
            [ -d go ] && mv go $HOME/.go
            go install golang.org/x/tools/gopls@latest
            go install github.com/charmbracelet/glow@latest
            printf "%s\n" "GO DONE" &>> ${SUMMARY}
        else
            printf "%s\n" "GO ISNT INSTALLED - SKIP" &>> ${SUMMARY}
        fi
    } &>> ${LOG}

    substep "Installing Npm Packages..."
    {
        if command -v npm; then
            sudo npm i -g bash-language-server
            sudo npm i -g typescript typescript-language-server
            sudo npm i -g vscode-langservers-extracted
            sudo npm i -g cssmodules-language-server
            printf "%s\n" "NPM DONE" &>> ${SUMMARY}
        else
            printf "%s\n" "NPM ISNT INSTALLED - SKIP" &>> ${SUMMARY}
        fi
    } &>> ${LOG}

    substep "Installing Lua Packages..."
    {
        pushd ~/Documents/programs
            git clone https://github.com/LuaLS/lua-language-server
            cd lua-language-server
            # ./make.sh
            printf "%s\n" "LUA DONE" &>> ${SUMMARY}
        popd
    } &>> ${LOG}
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
        printf "%s\n" "SERVICES DONE" &>> ${SUMMARY}
    } &>> ${LOG}
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
                        make stow
                    popd
                    printf "%s\n" "DOTFILES DONE" &>> ${SUMMARY}
                else
                    printf "%s\n" "DOTFILES PULL DOWN ERROR - SKIP" &>> ${SUMMARY}
                    exit -1
                fi
            else
		        pushd .dotfiles
		            make stow
		        popd
		        printf "%s\n" "DOTFILES DONE" &>> ${SUMMARY}
            fi

            if ! [ -d .web ]; then
                git clone "${GITHUB}/duclos-cavalcanti.github.io.git" .web
                printf "%s\n" "WEB DONE" &>> ${SUMMARY}
            else
		        printf "%s\n" "WEB ALREADY PRESENT" &>> ${SUMMARY}
            fi
        popd
    } &>> ${LOG}
}

groups() {

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
    groups

    printf "
     _______________________
    |  ___________________  |
    | | Installation Done | |
    | |___________________| |
    |_______________________|
    \n"
}

main "$@"
