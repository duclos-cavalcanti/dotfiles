#!/bin/bash

usage() {
    local script_name=$(basename $0)
    echo "USAGE:
      syntax: ./${script_name} <target>

      ${script_name} has:
      1) the following targets:
        * config: path to an awesome config
        "
}

print_error() {
    echo "ERROR: $*" >&2
}

dependencies() {
    for c in neomutt gpg pass; do
        if command -v ${c} &>/dev/null; then
            echo "ERROR: ${c} is not found in the system!" >&2
            echo "Installing..."
            sudo pacman -S ${c}
        fi
    done
}

main() {
    dependencies
}

main "$@"
