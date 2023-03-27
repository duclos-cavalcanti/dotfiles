#!/bin/bash

for c in neomutt gpg pass; do
    if command -v ${c} &>/dev/null; then
        printf "%s\n" "ERROR: ${c} is not found in the system!" >&2
        printf "%s\n" "Installing..."
        sudo apt install ${c}
    fi
done
