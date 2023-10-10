
return {
    name = "dotfiles",
    dir = os.getenv('HOME') .. "/.dotfiles",
    tabs = {
        {
            name = "readme",
            cmds = {
                "nvim README.md"
            },
        },
        {
            name = "wm",
            dir = os.getenv('HOME') .. "/.config/awesome",
            cmds = {
                "nvim rc.lua"
            },
        },
        {
            name = "term",
            dir = os.getenv('HOME') .. "/.config/wezterm",
            cmds = {
                "nvim wezterm.lua"
            },
        },
        {
            name = "editor",
            dir = os.getenv('HOME') .. "/.config/nvim",
            cmds = {
                "nvim init.lua"
            },
        },
        {
            name = "bash",
            cmds = {
                "clear",
                "nvim install.sh",
            },
        },
    }
}
