#!/bin/bash



# dconf list /path/to/directory/
#
# dconf read /path/to/key
# dconf read -d /path/to/key (DEFAULT VALUE EXAMPLE)
#
# dconf write /path/to/key "'value'"
# dconf write /path/to/key "['first', 'second', ...]"
# dconf write /path/to/key "@as []" (EMPTY VALUE EXAMPLE)

# dconf reset /path/to/key
# dconf reset -f /path/to/directory/




# dconf dump /path/to/directory/
dump() {
    local path=$1
    dconf dump "${path}"
}

dash() {
    local root="/org/gnome/shell/extensions/dash-to-dock/"
    local app="app-hotkey"
    dconf write "${root}${app}-1" "@as []"
    dconf write "${root}${app}-2" "@as []"
    dconf write "${root}${app}-3" "@as []"
    dconf write "${root}${app}-4" "@as []"
    dconf write "${root}${app}-5" "@as []"
    dconf write "${root}${app}-6" "@as []"
    dconf write "${root}${app}-7" "@as []"
    dconf write "${root}${app}-8" "@as []"
    dconf write "${root}${app}-9" "@as []"
    dconf write "${root}${app}-10" "@as []"

    local app="app-shift-hotkey"
    dconf write "${root}${app}-1" "@as []"
    dconf write "${root}${app}-2" "@as []"
    dconf write "${root}${app}-3" "@as []"
    dconf write "${root}${app}-4" "@as []"
    dconf write "${root}${app}-5" "@as []"
    dconf write "${root}${app}-6" "@as []"
    dconf write "${root}${app}-7" "@as []"
    dconf write "${root}${app}-8" "@as []"
    dconf write "${root}${app}-9" "@as []"
    dconf write "${root}${app}-10" "@as []"
}

main() {

}

main $@

