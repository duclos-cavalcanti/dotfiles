
return {
    name = "web",
    dir = os.getenv('HOME') .. "/Documents/stuff/personal/duclos-cavalcanti.github.io",
    tabs = {
        {
            name = "readme",
            cmds = {
                "nvim README.md"
            },
        },
        {
            name = "sh",
            cmds = {
                "nvim build.sh"
            },
        },
        {
            name = "web",
            cmds = {
                "nvim pages/index.md"
            },
        },
        {
            name = "bash",
            cmds = {
                "clear && make serve",
                "nvim Makefile"
            },
        },
        {
            name = "github",
            dir = os.getenv('HOME') .. "/Documents/stuff/personal/duclos-cavalcanti",
            cmds = {
                "nvim README.md"
            },
        },
    }
}
