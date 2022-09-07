#!/bin/sh
#
# Inspired by hashwall from xero <x@xero.nu>, found at http://code.xero.nu/dotfiles.
# Requires: imagemagick + hsetroot

usage() {
	echo "usage: `basename $0` <bg> <fg> <step> <res>
    bg background color (required)
    fg foreground color (required)
    step step           (4:default)
    res resolution      (24:default)"
	exit 1
}

# args
[ -z "$1" ] && usage  || bg="$1"
[ -z "$2" ] && usage  || fg="$2"
[ -z "$3" ] && step=4 || step="$3"
[ -z "$4" ] && res=24 || res="$4"


if ! command -v hsetroot &>/dev/null; then
    printf "%s\n" "Requires hsetroot"
    exit 1
fi

if ! command -v convert &>/dev/null; then
    printf "%s\n" "Requires imagemagick"
    exit 1
fi

# calculate
max=$((res*2+2))
i=0
lines=""
while
	lines="$lines line $i,-1 -1,$i"
	i="$((i+step))"
	[ "$i" -lt "$max" ]
do :; done

# generate
convert -size ${res}x${res} xc:${bg} -stroke ${fg} -draw "${lines}" /tmp/wall.png
hsetroot -tile /tmp/wall.png
