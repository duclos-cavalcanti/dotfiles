#!/bin/bash

SESSION=
DIR=
if ! command -v tmux &>/dev/null; then
    echo "tmux is not installed"
    exit 1
fi

err() {
    printf "%s\n" "${1}"
    exit 1
}

session() {
    if tmux has-session -t ${1} 2>/dev/null; then
        err "Session ${1} already exists!"
    fi

    if [ ! -d ${2} ]; then
        err "Directory ${2} doesn't exist!"
    fi

    SESSION=${1}
    DIR=${2}

    tmux new-session -d -s ${1} -c ${2}
}

wrename() {
    local name=$1
    tmux rename-window -t ${SESSION} "${name}"
}

wnew() {
    local name=$1
    local dir=$2
    if [ -n "${dir}" ]; then 
        tmux new-window -n "${name}" -c "${dir}"
    else 
        tmux new-window -n "${name}" -c "${DIR}"
    fi
}

wsend() {
    local i=$1
    local command=${2}
    tmux send-keys -t ${SESSION}:${i} "${command}" C-m

}

wsplit() {
    # 'empty' for horizontally or -h for vertically
    local ori=${1}
    local dir=$2
    if [ -n "${dir}" ]; then 
        tmux split-window ${ori} -t ${SESSION} -c ${dir}
    else 
        tmux split-window  ${ori} -t ${SESSION} -c ${DIR}
    fi
}

wsel() {
    tmux select-window -t ${SESSION}:${1}
}

main() {
    local -A templates=(
        [dotfiles]="$HOME/.dotfiles"
        [web]="$HOME/.web"
        [work]="$HOME/Documents/work/master-arbeit"
    )

    [[ -z "${templates["${1}"]}" ]] && err "Template for ${1}:${templates[${1}]} does not exist!"

    dotfiles() {
        wrename     "readme"
        wsend       1 "nvim README.md"

        wnew        "bash"
        wsplit
        wsend       2.1 "ls -l"
        wsend       2.2 "nvim install.sh -c 'tabedit ~/.bin/launch.sh'"

        wnew        "rc" "${HOME}"
        wsend       3 "nvim .bashrc"

        wnew        "mux" "${HOME}"
        wsend       4 "nvim .tmux.conf"

        wnew        "editor" "${HOME}/.config/nvim/"
        wsend       5 "nvim init.lua"

        wsel        2
    }

    web() {
        wrename     "readme"
        wsend       1 "nvim README.md"

        wnew        "bash"
        wsplit
        wsend       2.1 "make serve"
        wsend       2.2 "nvim build.sh -c 'vsplit Makefile'"

        wnew        "web"
        wsend       3 "nvim pages/about/index.md"

        wnew        "cover"
        wsend       4 "nvim cover/cover.md -c 'tabedit cover/template.tex'"

        wnew        "github" "/home/duclos/Documents/stuff/personal/duclos-cavalcanti"
        wsend       5 "nvim README.md"

        wsel        2
    }

    work() {
        wrename     "readme"
        wsend       1 "nvim README.md"

        wnew        "dev"
        wsend       2 "ls -l"

        wnew        "sh" "${DIR}/module"
        wsend       3 "ls -l"

        wnew        "src" "${DIR}/module/src"
        wsend       4 "make dev"

        wsel        2
    }

    session ${1} "${templates["${1}"]}" 
    ${1}
}

main $@
