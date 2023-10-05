
return {
    name = "xwm",
    dir = os.getenv('HOME') .. "/Documents/stuff/c/xwm",
    tabs = {
        {
            name = "readme",
            cmds = {
                "nvim README.md"
            },
        },
        {
            name = "src",
            cmds = {
                "nvim src/main.c"
            },
        },
        {
            name = "bash",
            cmds = {
                "clear",
                "ls - l"
            },
        },
        {
            name = "cmake",
            cmds = {
                "nvim CMakeLists.txt"
            },
        },
    }
}
