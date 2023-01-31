#!/bin/bash

if ! pgrep "$1"; then
    $@ &
fi
