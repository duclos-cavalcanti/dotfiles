
return {
    name = "work",
    dir = os.getenv('HOME') .. "/Documents/work/msc-thesis",
    tabs = {
        {
            name = "readme",
            cmds = {
                "nvim README.md"
            },
        },
        {
            name = "bash",
            cmds = {
                "ls"
            },
        },
        {
            name = "wiki",
            dir = os.getenv('HOME') .. "/Documents/work/msc-thesis.wiki",
            cmds = {
                "nvim Home.md"
            },
        },
    }
}
