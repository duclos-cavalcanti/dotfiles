#!/usr/bin/lua
-- requires lua to be installed

local EXIT_ERR  = -1
local EXIT_SUCC = 0

local function usage()
    print([[
syntax: ./generate.lua <theme>

generate.lua has:
1) the following themes:
  * dark
  * light
  * test
  * regular
    ]])
end

local indent = {}
indent.tab = ""

function indent.inc()
    indent.tab = string.format("%s\t", indent.tab)
end

function indent.dec()
    local len = string.len(indent.tab)
    if len > 0 then
        indent.tab = ""
        for _ = 1, len - 1, 1 do
            indent.inc()
        end
    end
end

local function main(palette)
    print("Theme: ", palette)
    local colors = dofile(string.format("palette/%s.lua", palette))

    if colors == nil then
        print(string.format("Loaded palette file at: palette/%s.lua is faulty!", palette))
        os.exit(EXIT_ERR)
    end

    local function create()
        local function newline(fw)
            fw:write("\n")
        end

        local function write(fw, i, str)
            fw:write(string.format("%s%s\n", i.tab, str))
        end

        local fw = io.open(string.format("%s.yml", palette), "w+")
        write(fw, indent, "colors:"); indent.inc()

        write(fw, indent, "primary:"); indent.inc()

        write(fw, indent, string.format("background:\t'%s'", colors.bg))
        write(fw, indent, string.format("foreground:\t'%s'", colors.fg))

        newline(fw)
        indent.dec(); write(fw, indent, "cursor:"); indent.inc()
        write(fw, indent, string.format("text:\t'%s'", colors.bg))
        write(fw, indent, string.format("cursor:\t'%s'", colors.fg))

        newline(fw)
        indent.dec(); write(fw, indent, "vi_mode_cursor:"); indent.inc()
        write(fw, indent, string.format("text:\t'%s'", colors.bg))
        write(fw, indent, string.format("cursor:\t'%s'", colors.fg))

        newline(fw)
        indent.dec(); write(fw, indent, "selection:"); indent.inc()
        write(fw, indent, string.format("text:\t'%s'", colors.bg))
        write(fw, indent, string.format("cursor:\t'%s'", colors.fg))

        newline(fw)
        indent.dec(); write(fw, indent, "normal:"); indent.inc()
        write(fw, indent, string.format("black:\t'%s'", colors.black))
        write(fw, indent, string.format("red:\t'%s'", colors.red))
        write(fw, indent, string.format("green:\t'%s'", colors.green))
        write(fw, indent, string.format("yellow:\t'%s'", colors.yellow))
        write(fw, indent, string.format("blue:\t'%s'", colors.blue))
        write(fw, indent, string.format("magenta:\t'%s'", colors.magenta))
        write(fw, indent, string.format("cyan:\t'%s'", colors.cyan))
        write(fw, indent, string.format("white:\t'%s'", colors.white))

        newline(fw)
        indent.dec(); write(fw, indent, "bright:"); indent.inc()
        write(fw, indent, string.format("black:\t'%s'", colors.black2))
        write(fw, indent, string.format("red:\t'%s'", colors.red2))
        write(fw, indent, string.format("green:\t'%s'", colors.green2))
        write(fw, indent, string.format("yellow:\t'%s'", colors.yellow2))
        write(fw, indent, string.format("blue:\t'%s'", colors.blue2))
        write(fw, indent, string.format("magenta:\t'%s'", colors.magenta2))
        write(fw, indent, string.format("cyan:\t'%s'", colors.cyan2))
        write(fw, indent, string.format("white:\t'%s'", colors.white2))

        fw:close()
    end

    create()
end

local palette = arg[1]
if palette == nil then
    usage()
    os.exit(EXIT_ERR)
else
    main(palette)
    os.exit(EXIT_SUCC)
end
