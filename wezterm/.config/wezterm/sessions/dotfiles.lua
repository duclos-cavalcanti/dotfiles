
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
    }
}
