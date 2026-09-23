#!/bin/sh
# theme.sh — switch the active color scheme (repo tool; sibling of stow.sh).
# Renders theme/<scheme>.yaml into the "custom" slot for both consumers via the
# repo's base16 generator, and records the choice in theme/current (the active-
# scheme pointer; git-ignored machine state).
#
#   ./theme.sh <scheme>   activate scheme (resolved to theme/<scheme>.yaml)
#   ./theme.sh            print the active scheme and list the available ones
#
# Reload is manual: ghostty via its reload-config keybind, nvim via restart.

DIR=$(cd -- "$(dirname -- "$0")" && pwd)
THEME_DIR="$DIR/theme"
BASE16="$DIR/home/.bin/base16"
NVIM_LUA="$DIR/home/.config/nvim/lua/theme/custom.lua"
GHOSTTY="$DIR/home/.config/ghostty/themes/custom"

list() {
    for f in "$THEME_DIR"/*.yaml; do
        [ -e "$f" ] || continue
        basename "$f" .yaml
    done
}

scheme=$1

if [ -z "$scheme" ]; then
    printf 'active: %s\n' "$(cat "$THEME_DIR/current" 2>/dev/null || echo '(none)')"
    echo 'available:'
    list | sed 's/^/  /'
    exit 0
fi

if [ ! -f "$THEME_DIR/$scheme.yaml" ]; then
    echo "theme.sh: no such scheme: $scheme" >&2
    echo "available: $(list | paste -sd' ' -)" >&2
    exit 1
fi

"$BASE16" lua     "$THEME_DIR/$scheme.yaml" > "$NVIM_LUA" || exit 1
"$BASE16" ghostty "$THEME_DIR/$scheme.yaml" > "$GHOSTTY"  || exit 1
printf '%s\n' "$scheme" > "$THEME_DIR/current"

echo "theme -> $scheme (reload ghostty + restart/re-source nvim)"
