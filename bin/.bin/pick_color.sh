#!/bin/bash

if ! command -v xclip &>/dev/null; then
    exit 1
fi

if ! command -v xcolor &>/dev/null; then
    exit 1
fi

xcolor | sed s/\\n//g | xclip -i -sel clip

