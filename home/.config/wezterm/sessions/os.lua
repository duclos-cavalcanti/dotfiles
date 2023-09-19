
return {
    name = "os",
    dir = os.getenv('HOME') .. "/Documents/work/os-nyu",
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
    }
}
