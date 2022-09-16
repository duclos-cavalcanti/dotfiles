#!/bin/bash
#
# changing theme of system

theme=$1

DOTFILES="$HOME/.dotfiles"
AWESOME_DIR="$HOME/.config/awesome"
ALACRITTY_DIR="$HOME/.config/alacritty/"
NVIM_DIR="$HOME/.config/nvim"

usage() {
  echo "USAGE:
    syntax: ./change.sh <theme> <cmd>

    change.sh has:
    1) the following themes:
      * dark
      * light
      * regular
      * test
      "
}

step() {
    echo "
    Step: ${1}
    -------------------------->
    "
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

if [ "$theme" != "dark" ]  || \
   [ "$theme" != "light" ] || \
   [ "$theme" != "test" ] || \
   [ "$theme" != "regular" ]; then
    :
else
  usage
  exit 1
fi

generate_yml() {
  local theme=$1
  step "Generate ${theme} colorscheme in yaml!"
  pushd $DOTFILES
  pushd "themes"
    ./generate.lua $theme
    if [ $? -eq 0 ]; then
      local colors=${theme}.yml
      if [ -f $colors ]; then
        sed -i 's/\t/\ \ /g' $colors
        mv -v $colors ~/Downloads/
      fi
    else
      popd; popd
      echo "generate.lua has failed!"
      exit -1
    fi
    popd
    popd
}

switch_term() {
  local theme=$1
  local colors="$HOME/Downloads/${theme}.yml"
  step "Terminal theming!"
  if [ -f $colors ]; then
    pushd $ALACRITTY_DIR
        printf "%s\n" "Changing to -> ${theme}"
        cp -v colors.yml ~/Downloads/last-scheme.yml
        mv -v $colors colors.yml
    popd
  else
    echo "yaml color scheme not found!"
    exit -1
  fi
}

switch_editor() {
  local theme=$1
  step "Editor theming!"
  pushd $NVIM_DIR
    pushd lua
      local patt="vim.g.custom_palette "
      local output=$(grep -n "${patt}" themes.lua)
      local line=$(grep --color=never -n "${patt}" themes.lua | cut -d ":" -f1)
      local current=$(echo $output | cut -d "=" -f2 | sed s/\"//g | sed -e 's/^[ \t]*//')
      local subst="${line}s/${current}/${theme}/g"

      if [ -z "$output" ]; then
        echo "Line with vim.g.custom_palette not found in themes.lua"
        popd; popd
        exit -1
      else
        printf "%s" "Changing from ${current} -> ${theme}"
        sed -i "${subst}" themes.lua
      fi
    popd
  popd
}

switch_wm() {
  local theme=$1
  step "Window Manager theming!"
  pushd $AWESOME_DIR
    pushd theme
      local patt="^local palette "
      local output=$(grep -n "${patt}" theme.lua)
      local line=$(grep --color=never -n "${patt}" theme.lua | cut -d ":" -f1)
      local current=$(grep -n "${patt}" theme.lua | cut -d "=" -f2 | sed s/\"//g | sed -e 's/^[ \t]*//')
      local subst="${line}s/${current}/${theme}/g"

      if [ -z "$output" ]; then
        echo "Line with palette variable not found in theme.lua"
        popd; popd
        exit -1
      else
        printf "%s" "Changing from ${current} -> ${theme}"
        sed -i "${subst}" init.lua
      fi
    popd
  popd
}


main() {
    # nvim awesome and alacritty
    generate_yml    $theme
    switch_wm       $theme
    echo -e "\n"; sleep 1s

    switch_term     $theme
    echo -e "\n"; sleep 1s

    switch_editor   $theme
    echo -e "\n"; sleep 1s
}

main "$@"
