#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CLEAR='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${CLEAR} $1"
}

print_section() {
    echo -e "${YELLOW}=== $1 ===${CLEAR}"
}

function install_brew() {
    print_section "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function install_packages() {
    print_section "Installing packages from Brewfile"
    if [ -f "Brewfile" ]; then
        # Pre-trust every third-party tap declared in the Brewfile — brew
        # refuses to load formulae from untrusted taps during bundle.
        grep -E '^tap "' Brewfile | sed -E 's/^tap "([^"]+)".*/\1/' | while read -r t; do
            brew tap "$t" 2>/dev/null && brew trust "$t" 2>/dev/null
        done
        brew bundle install
        print_status "Packages installed successfully"
    else
        echo "Brewfile not found!"
        exit 1
    fi
}

function install_docker_plugins() {
    print_section "Linking docker CLI plugins"
    # Homebrew installs docker CLI plugins under $(brew --prefix)/lib/docker/
    # cli-plugins, a dir the docker CLI does NOT search by default -- so the
    # `docker compose` / `docker buildx` subcommand forms aren't found (the
    # hyphenated binaries on PATH still work regardless). Link whatever plugins
    # are installed into ~/.docker/cli-plugins, a default search dir. Idempotent.
    local src
    src="$(brew --prefix)/lib/docker/cli-plugins"
    if [ ! -d "$src" ]; then
        print_status "No docker CLI plugins found, skipping"
        return 0
    fi
    mkdir -p "$HOME/.docker/cli-plugins"
    shopt -s nullglob
    for p in "$src"/*; do
        ln -sfn "$p" "$HOME/.docker/cli-plugins/$(basename "$p")"
    done
    shopt -u nullglob
    print_status "docker CLI plugins linked"
}

function install_dotfiles() {
    print_section "Setting up dotfiles with stow"
    if [ -f "stow.sh" ]; then
        ./stow.sh --install
        print_status "Dotfiles installed successfully"
    else
        echo "stow.sh not found!"
        exit 1
    fi
}

function install_git_config() {
    print_section "Configuring git difftool (neovim diff mode)"
    # difftool (~/.bin) adapts `git difftool` to Neovim for both file diffs
    # and --dir-diff (two temp dirs, as lazygit's <c-t>/openDiffTool uses).
    git config --global diff.tool nvimdiff
    git config --global difftool.nvimdiff.cmd 'difftool "$LOCAL" "$REMOTE"'
    git config --global difftool.prompt false
    print_status "git difftool configured successfully"
}

function main() {
    print_status "Starting macfiles setup..."

    # Run from the repo root regardless of where the script is invoked from.
    cd "$(dirname "$0")" || exit 1

    # Check if we're on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo "This script is designed for macOS only."
        exit 1
    fi

    install_brew
    install_packages
    install_docker_plugins
    install_dotfiles
    install_git_config

    print_status "Setup complete!"
    echo
}

main "$@"
