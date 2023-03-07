local M = {}

local function extend(tb, ext)
	for k, v in pairs(ext) do
        tb[k] = v
	end

    return tb
end

local function group(tb, g, hi)
	for _, k in ipairs(g) do
        tb[k] = hi
	end

    return tb
end

function M.plugins(cfg, cl)
    local tb = {}
    local function telescope(config, c)
        local t = {}
        t = {
            -- Telescope
            TelescopeBorder = {
                fg = c.editor.ui.floatwin.border,
            },
            TelescopeNormal = {
                bg = c.editor.ui.floatwin.bg,
                fg = c.editor.ui.floatwin.fg,
            },
            TelescopePromptPrefix = {
                fg = c.editor.ui.floatwin.prompt,
            },
            TelescopeSelection = {
                bg = c.editor.ui.floatwin.selected.bg,
                fg = c.editor.ui.floatwin.selected.fg,
            },
            TelescopeMatching = {
                fg = c.editor.ui.floatwin.match,
            },
        }
        return t
    end
    local function treesitter(config, c)
        local t = {}

	    local punctuation = {
            "@punctuation",         -- punctuation
        }

	    local constants = {
            "@constant",            -- For constants
            "@constant.builtin",    -- For constant that are built in the language: `nil` in Lua.
            "@constant.macro"       -- For constants that are defined by macros: `NULL` in C.
        }


	    local constructors = {
            "@constructor"     -- For constructor calls and definitions: `= { }` in Lua
        }

	    local boolean = {
            "@boolean"
        }

	    local functions = {
            "@function",            -- For function (calls and definitions).
            "@function.macro",      -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        }

	    local functions_builtin = {
            "@function.builtin",    -- For builtin functions: `table.insert` in Lua.
        }

	    local methods = {
            "@method"          -- For method calls and definitions.
        }

	    local fields = {
            "@field",          -- For fields.
            "@property"        -- Same as `TSField`.
        }

	    local number = {
            "@number",
            "@float"
        }

	    local parameters = {
            "@parameter",           -- For parameters of a function.
        }

	    local operators = {
            "@operator"            -- For any operator: `+`, but also `->` and `*` in C.
        }

	    local forwords = {
            "@conditional",        -- For keywords related to conditionnals.
            "@repeat"              -- For keywords related to loops.
        }

	    local keyword = {
            "@keyword",             -- For keywords that don't fall in previous categories.
        }

	    local types = {
            "@type",               -- For types.
            "@type.definition",    -- For builtin types.
        }

	    local labels = {
            "@label",                -- For labels: `label:` in C and `:label:` in Lua.
        }

	    local namespaces = {
            "@namespace"           -- For identifiers referring to modules and namespaces.
        }

	    local includes = {
            "@include"             -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        }

	    local variables = {
            "@variable",           -- Any variable name that does not have another highlight.
        }

	    local tags = {
            "@tag",                -- Tags like html tag names.
        }

	    local title = {
            "@text.title"               -- Text that is part of a title.
        }

	    local todo = {
            "@text.todo"
        }

        local text = {
            "@text.reference",
            "@text.literal",            -- Literal text.
            "@text.underline",          -- Literal text.
            "@text.uri"                 -- Any URI like a link or email.
        }

        t = group(t, punctuation, {
            fg = c.editor.punctuation
        })
        t = group(t, constructors, {
            fg = c.editor.constructor
        })
        t = group(t, boolean, {
            fg = c.editor.bool
        })
        t = group(t, functions, {
            fg = c.editor.functions,
            style = config.function_style
        })
        t = group(t, functions_builtin, {
            fg = c.editor.fbuiltin,
        })
        t = group(t, methods, {
            fg = c.editor.method,
            style = "italic"
        })
        t = group(t, fields, {
            fg = c.editor.field,
        })
        t = group(t, number, {
            fg = c.editor.number,
        })
        t = group(t, parameters, {
            fg = c.editor.fparameters,
        })
        t = group(t, operators, {
            fg = c.editor.operator,
        })
        t = group(t, forwords, {
            fg = c.editor.forwords,
        })
        t = group(t, keyword, {
            fg = c.editor.keyword,
            style = config.keyword_style
        })
        t = group(t, labels, {
            fg = c.editor.label,
        })
        t = group(t, types, {
            fg = c.editor.type,
        })
        t = group(t, namespaces, {
            fg = c.editor.namespace,
        })
        t = group(t, includes, {
            fg = c.editor.preproc,
        })
        t = group(t, variables, {
            fg = c.editor.var,
            style = config.variable_style
        })
        t = group(t, tags, {
            fg = c.editor.text.tag,
        })
        t = group(t, title, {
            fg = c.editor.text.title,
        })
        t = group(t, text, {
            fg = c.fg,
        })
        t = group(t, todo, {
            fg = c.editor.text.todo,
        })
        t = group(t, constants, {
            fg = c.editor.constant
        })

        return t
    end
    local function lsp(config, c)
        local t = {}
        t = {
            DiagnosticWarning = {
                link = "DiagnosticWarn"
            },
            DiagnosticInformation = {
                link = "DiagnosticInfo"
            },
            LspFloatWinNormal = {
                bg = c.editor.ui.sidebar.bg,
            },
            LspFloatWinBorder = {
                bg = c.editor.ui.sidebar.bg_alt,
            },
            ReferencesCount = {
                fg = c.editor.number,
            },
            DefinitionCount = {
                fg = c.editor.number,
            },
            DefinitionIcon = {
                fg = c.editor.icons,
            },
            ReferencesIcon = {
                fg = c.editor.icons,
            },
            TargetWord = {
                fg = c.editor.text.title,
            },
        }
        return t
    end
    local function cmp(config, c)
        local t = {}
        t = {
            -- Cmp
            CmpItemMenu = {
                fg = c.editor.ui.popmenu.fg,
            },
            CmpItemAbbr = {
                fg = c.editor.ui.popmenu.abbreviation,
            },
            CmpItemAbbrMatch = {
                fg = c.editor.ui.popmenu.selected,
            },
            CmpItemAbbrMatchFuzzy = {
                fg = c.editor.ui.popmenu.fuzzy,
            },
            CmpItemKind = {
                fg = c.editor.ui.popmenu.kind,
            },
        }
        return t
    end
    local function neogit(config, c)
        local t = {}
        t = {
            -- Neogit
            NeogitDiffContextHighlight = {
                fg = c.none,
                bg = c.editor.diff.change
            },
            NeogitDiffDeleteHighlight = {
                fg = c.bg,
                bg = c.editor.diff.delete
            },
            NeogitDiffAddHighlight = {
                fg = c.bg,
                bg = c.editor.diff.add
            },
        }
        return t
    end
    local function diff(config, c)
        local t = {}
        t = {
            -- diff
            diffAdded = {
                fg = c.editor.diff.add
            },
            diffRemoved = {
                fg = c.editor.diff.delete
            },
            diffChanged = {
                fg = c.editor.diff.change
            },
            diffOldFile = {
                fg = c.editor.diff.delete
            },
            diffNewFile = {
                fg = c.editor.diff.add
            },
            diffFile = {
                fg = c.editor.diff.file,
            },
            diffLine = {
                fg = c.editor.diff.line,
            },
            diffIndexLine = {
                fg = c.editor.cur_linenr,
            },
        }
        return t
    end
    local function neovim(config, c)
        local t = {}
        t = {
            -- NeoVim
            healthError = {
                fg = c.editor.error.fg
            },
            healthSuccess = {
                fg = c.editor.success.fg
            },
            healthWarning = {
                fg = c.editor.warning.fg
            },
        }
        return t
    end
    local function nvim_dap_ui(config, c)
        local t = {}

        return t
    end

    tb = extend(tb, treesitter(cfg, cl))
    tb = extend(tb, telescope(cfg, cl))
    tb = extend(tb, lsp(cfg, cl))
    tb = extend(tb, cmp(cfg, cl))
    tb = extend(tb, diff(cfg, cl))
    tb = extend(tb, neogit(cfg, cl))
    tb = extend(tb, neovim(cfg, cl))

    return tb
end

g_custom_lualine={}

function M.get_lualine()
    return g_custom_lualine
end

function M.lualine(config, c)
    local tb = {}
    local l = {
        normal = {
          a = { bg = c.editor.ui.statusline.line.a.normal.bg,
                fg = c.editor.ui.statusline.line.a.normal.fg
            },
          b = { bg = c.editor.ui.statusline.line.b.bg,
                fg = c.editor.ui.statusline.line.b.fg,
                gui = "bold"
            },
          c = { bg = c.editor.ui.statusline.line.c.bg,
                fg = c.editor.ui.statusline.line.c.fg  },
        },
        insert = {
          a = { bg = c.editor.ui.statusline.line.a.insert.bg,
                fg = c.editor.ui.statusline.line.a.insert.fg
            },
          b = { bg = c.editor.ui.statusline.line.b.bg,
                fg = c.editor.ui.statusline.line.b.fg,
                gui = "bold"
            },
        },
        command = {
          a = { bg = c.editor.ui.statusline.line.a.command.bg,
                fg = c.editor.ui.statusline.line.a.command.fg
            },
          b = { bg = c.editor.ui.statusline.line.b.bg,
                fg = c.editor.ui.statusline.line.b.fg,
                gui = "bold"
            },
        },
        visual = {
          a = { bg = c.editor.ui.statusline.line.a.visual.bg,
                fg = c.editor.ui.statusline.line.a.visual.fg
            },
          b = { bg = c.editor.ui.statusline.line.b.bg,
                fg = c.editor.ui.statusline.line.b.fg,
                gui = "bold"
            },
        },
        replace = {
          a = { bg = c.red2, fg = c.black2 },
          b = { bg = c.editor.ui.statusline.line.b.bg,
                fg = c.editor.ui.statusline.line.b.fg,
                gui = "bold"
            },
        },
        inactive = {
          a = { bg = c.editor.ui.statusline.bg, fg = c.white2 },
          b = { bg = c.editor.ui.statusline.line.b.bg,
                fg = c.editor.ui.statusline.line.b.fg,
                gui = "bold"
            },
          c = { bg = c.editor.ui.statusline.bg, fg = c.white2 },
        },
    }

    if config.lualine_bold then
        for _, mode in pairs(l) do
            mode.a.gui = "bold"
        end
    end

    if config.inactive_statusline then
        local inactive = {
            style = "underline",
            bg = c.editor.ui.statusline.nc.bg,
            fg = c.editor.ui.statusline.nc.fg,
            sp = c.editor.ui.statusline.nc.fg
        }
        for _, section in ipairs({ "a", "b", "c" }) do
            tb["lualine_" .. section .. "_inactive"] = inactive
        end
    end

    g_custom_lualine = l
    return tb
end

function M.debug(config, c)
    local tb = {}
    tb = {
        -- used for highlighting the current line in terminal-debug
        debugPC = {
            bg = c.black
        },
        -- used for breakpoint colors in terminal-debug
        debugBreakpoint = {
            bg = c.none,
            fg = c.red
        },
    }

    return tb
end

function M.markup(config, c)
    local tb = {}
    tb = {
        htmlH1 = {
            fg = c.white2,
            bg = c.black,
            style = "bold"
        },
        htmlH2 = {
            fg = c.white2,
            bg = c.black,
            style = "bold"
        },
        markdownh1 = {
            fg = c.white2,
            bg = c.black,
            style = "bold"
        },
        markdownh2 = {
            fg = c.white2,
            bg = c.black,
            style = "bold"
        },
        markdownh3 = {
            fg = c.white2,
            bg = c.black,
            style = "bold"
        },
        markdownh4 = {
            fg = c.white2,
            bg = c.black,
            style = "bold"
        },
        markdownh5 = {
            fg = c.fg,
            bg = c.black,
            style = "bold"
        },
        markdownCodeDelimiter = {
            bg = c.red2,
            fg = c.green
        },
        markdownCodeBlock = {
            fg = c.grey
        },
        markdownCode = {
            fg = c.grey
        },
        markdownCodeStart = {
            fg = c.grey,
            style = "bold"
        },
        markdownCodeEnd = {
            fg = c.grey,
            style = "bold"
        },
        markdownLinkText = {
            fg = c.cyan,
            style = "underline"
        },
        markdownLinkTextDelimiter = {
            fg = c.grey,
            style = "underline"
        },
        markdownLinkDelimiter = {
            fg = c.grey,
            style = "underline"
        },
    }

	local delimiters = {
        "markdownH1Delimiter",
		"markdownH2Delimiter",
		"markdownH3Delimiter",
		"markdownH4Delimiter",
		"markdownH5Delimiter",
		"markdownH6Delimiter",
	}

    tb = group(tb, delimiters, {
            fg = c.magenta,
            bg = c.red2,
            style = "bold"
    })

    return tb
end

function M.diagnostics(config, c)
    local tb = {}
    tb = {
        -- Base highlight groups
        -- Diagnostic highlights link to this by default
        DiagnosticError = {
            bg = c.editor.error.bg,
            fg = c.editor.error.fg
        },
        DiagnosticWarn = {
            bg = c.editor.warning.bg,
            fg = c.editor.warning.fg
        },
        DiagnosticInfo = {
            bg = c.editor.info.bg,
            fg = c.editor.info.fg
        },
        DiagnosticHint = {
            bg = c.editor.hint.bg,
            fg = c.editor.hint.fg
        },
        -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextError = {
            bg = c.none,
            fg = c.editor.error.fg
        },
        -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextWarn = {
            bg = c.none,
            fg = c.editor.warning.fg
        },
        -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextInfo = {
            bg = c.none,
            fg = c.editor.info.fg
        },
        -- Used for "Hint" diagnostic virtual text
        DiagnosticVirtualTextHint = {
            bg = c.none,
            fg = c.editor.hint.fg
        },
        -- Used to underline "Error" diagnostics
        DiagnosticUnderlineError = {
            -- style = "undercurl",
            sp = c.editor.error.fg
        },
        -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineWarn = {
            -- style = "undercurl",
            sp = c.editor.error.fg
        },
        -- Used to underline "Information" diagnostics
        DiagnosticUnderlineInfo = {
            -- style = "undercurl",
            sp = c.editor.info.fg
        },
        -- Used to underline "Hint" diagnostics
        DiagnosticUnderlineHint = {
            -- style = "undercurl",
            sp = c.editor.hint.fg
        },

    }

    if not vim.diagnostic then
        local severity_map = {
            Error = "Error",
            Warn = "Warning",
            Info = "Information",
            Hint = "Hint",
        }
        local types = { "Default", "VirtualText", "Underline" }
        for _, type in ipairs(types) do
            for k, v in pairs(severity_map) do
                tb["LspDiagnostics" .. type .. v] = {
                    link = "Diagnostic" .. (type == "Default" and "" or type) .. k,
                }
            end
        end
    end

    return tb
end

function M.lsp(config, c)
    local tb = {}
    tb = {
        -- used for highlighting "text" references
        LspReferenceText = {
            bg = c.grey
        },
        -- used for highlighting "read" references
        LspReferenceRead = {
            bg = c.grey
        },
        -- used for highlighting "write" references
        LspReferenceWrite = {
            bg = c.grey
        },
        LspSignatureActiveParameter = {
            fg = c.yellow2
        },
        LspCodeLens = {
            fg = c.grey
        },
    }

    return tb
end


function M.spell(config, c)
    local tb = {}
    tb = {
        -- Word that is not recognized by the spellchecker.
        SpellBad = {
            sp = c.editor.error.fg,
            style = "undercurl"
        },
        -- Word that should start with a capital.
        SpellCap = {
            sp = c.editor.warning.fg,
            style = "undercurl"
        },
        -- Word that is used in another region.
        SpellLocal = {
            sp = c.fg,
            style = "undercurl"
        },
        -- Word that is hardly ever used.
        SpellRare = {
            sp = c.editor.text.rare,
            style = "undercurl"
        },
    }

    return tb
end

function M.diff(config, c)
    local tb = {}
    tb = {
        -- diff mode:
        -- Added line
        DiffAdd = {
            fg = c.bg,
            bg = c.editor.diff.add
        },
        -- Changed line
        DiffChange = {
            fg = c.bg,
            bg = c.editor.diff.change
        },
        -- Deleted line
        DiffDelete = {
            fg = c.bg,
            bg = c.editor.diff.delete
        },
        -- Changed text within a line
        DiffText = {
            fg = c.editor.diff.text,
            bg = c.bg,
        },
    }

    return tb
end

function M.base(config, c)
    local tb = {
        -- normal text
        Normal = {
            bg = (config.transparent and c.none) or c.bg,
            fg = c.fg,
        },
        -- normal text in non-current windows
        NormalNC = {
            link = "Normal"
        },
        -- normal text in non-current windows
        NormalSB = {
            link = "Normal"
        },
        -- normal text in floating windows.
        NormalFloat = {
            link = "Normal"
        },
        FloatBorder = {
            fg = c.editor.ui.floatwin.border,
            bg = c.editor.ui.floatwin.bg_alt,
        },
        -- placeholder characters substituted for concealed text
        Conceal = {
            fg = c.editor.comment,
        },
        -- the column separating vertically split windows
        VertSplit = {
            fg = c.editor.ui.border
        },
        -- function name, also methods for classes
        Function = {
            fg = c.editor.functions,
            style = config.function_style
        },
        -- (preferred) any erroneous construct
        Error = {
            fg = c.editor.error.fg
        },
        -- error messages on the command line
        ErrorMsg = {
            bg = c.editor.error.bg,
            fg = c.editor.error.fg
        },
        -- warning messages
        WarningMsg = {
            fg = c.editor.warning.fg,
            bg = c.editor.warning.bg,
        },
        Exception = {
            fg = c.editor.error.fg
        },
        -- Boolean
        Boolean = {
            fg = c.editor.bool,
        },
        --  a character constant: 'c', '\n'
        Character = {
            fg = c.editor.char,
        },
        -- Comments
        Comment = {
            fg = c.editor.comment,
            style = config.comment_style
        },
        Conditional = {
            fg = c.editor.forwords,
        },
        -- (preferred) any constant
        Constant = {
            fg = c.editor.constant
        },
        Float = {
            fg = c.editor.number
        },
        -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        Search = {
            bg = c.editor.search.bg,
            fg = c.editor.search.fg
        },
        -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        IncSearch = {
            bg = c.editor.search.inc_bg,
            fg = c.editor.search.inc_fg
        },
        -- |:substitute| replacement text highlighting
        Substitute = {
            bg = c.editor.search.substitute,
            fg = c.bg
        },
        Number = {
            fg = c.editor.number
        },
        Define = {
            fg = c.editor.preproc
        },
        Delimiter = {
            fg = c.editor.punctuation
        },
        -- directory names
        Directory = {
            fg = c.editor.ui.directory
        },
        -- line used for closed folds
        Folded = {
            fg = c.editor.comment,
        },
        -- 'foldcolumn'
        FoldColumn = {
            fg = c.editor.comment,
        },
        -- any variable name
        Identifier = {
            fg = c.editor.var,
            style = config.variable_style
        },
        Include = {
            fg = c.editor.preproc,
        };
        --  any other keyword
        Keyword = {
            fg = c.editor.keyword,
            style = config.keyword_style
        },
        Label = {
            fg = c.editor.label,
            style = config.keyword_style
        },
        -- "sizeof", "+", "*", etc.
        Operator = {
            fg = c.editor.operator
        },
        -- (preferred) generic Preprocessor
        PreProc = {
            fg = c.editor.preproc
        },
        Repeat = {
            fg = c.editor.forwords
        };
        -- (preferred) any statement
        Statement = {
            fg = c.editor.statement
        },
        -- Keywords that affect how a variable is stored: `static`, `comptime`, `extern`,
        StorageClass = {
            fg = c.editor.storage
        },
        --   a string constant: "this is a string"
        String = {
            fg = c.editor.string
        },
        Structure = {
            fg = c.editor.structure
        },
        Tag = {
            fg = c.editor.text.tag
        },
        -- titles for output from ":set all", ":autocmd" etc.
        Title = {
            fg = c.editor.text.title,
            style = "bold"
        },
        -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Todo = {
            fg = c.editor.text.todo
        },
        -- (preferred) int, long, char, etc.
        Type = {
            fg = c.editor.type
        },
        -- (preferred) int, long, char, etc.
        Typedef = {
            fg = c.editor.type
        },
        Line = {
            fg = c.editor.ui.line,
        },
        -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        LineNr = {
            fg = c.editor.linenr,
            bg = c.editor.column
        },
        -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        CursorLineNr = {
            fg = c.editor.cur_linenr,
            bg = c.editor.column
        },
        -- screen-column at the cursor, when 'cursorcolumn' is set.
        CursorColumn = {
            fg = (config.columnline and c.white)
                 or c.none
        },
        -- column where |signs| are displayed
        SignColumn = {
            bg = config.transparent and c.none
                 or c.editor.column
        },
        -- column where |signs| are displayed
        SignColumnSB = {
            link = "SignColumn"
        },
        -- used columns set with 'colorcolumn'
        ColorColumn = {
            bg = config.colorcolumn and c.editor.ui.colorcolumn
            or c.none
        },
        -- screen-line at the cursor, when 'cursorline' is set.
        CursorLine = {
            bg = config.cursorline and c.editor.ui.cursorline
                 or c.none
        },
        -- character under the cursor
        Cursor = {
            bg = c.fg,
            fg = c.bg,
        },
        -- character under the cursor when |language-mapping| is used (see 'guicursor')
        lCursor = {
            fg = c.bg,
            bg = c.fg
        },
        -- like cursor, but used when in IME mode |CursorIM|
        CursorIM = {
            fg = c.bg,
            bg = c.fg
        },
        -- filler lines (~) after the end of the buffer
        EndOfBuffer = {
            fg = c.editor.comment
        },
        -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        MatchParen = {
            fg = c.editor.punctuation,
            style = "bold"
        },
        -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        NonText = {
            fg = c.editor.linenr
        },
        -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Whitespace = {
            fg = c.editor.icons
        },
        -- Popup menu: normal item.
        Pmenu = {
            bg = c.editor.ui.popmenu.bg,
            fg = c.editor.ui.popmenu.fg,
        },
        -- Popup menu: selected item.
        PmenuSel = {
            bg = c.editor.ui.popmenu.bg,
            fg = c.editor.ui.popmenu.selected,
        },
        -- Popup menu: scrollbar.
        PmenuSbar = {
            bg = c.editor.ui.popmenu.sbar.bg,
            fg = c.editor.ui.popmenu.sbar.fg,
        },
        -- Popup menu: Thumb of the scrollbar.
        PmenuThumb = {
            bg = c.editor.ui.popmenu.thumb.bg,
            fg = c.editor.ui.popmenu.thumb.fg,
        },
        -- current match in 'wildmenu' completion
        WildMenu = {
            bg = c.editor.ui.wildmenu
        },
        -- (preferred) any special symbol
        Special = {
            fg = c.editor.special
        },
        -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpecialKey = {
            fg = c.editor.special
        },
        SpecialChar = {
            fg = c.editor.special
        },
        SpecialComment = {
            link = "Comment"
        },
        -- status line of current window
        StatusLine = {
            fg = c.editor.ui.statusline.fg,
            bg = c.editor.ui.statusline.bg,
        },
        -- status lines of not-current windows
        -- Note: if this is equal to "StatusLine"
        -- Vim will use "^^^" in the status line of the current window.
        StatusLineNC = {
            style   = (config.inactive_statusline and "italic") or nil,
            fg      = (config.inactive_statusline and c.bg) or c.editor.ui.statusline.nc.fg,
            bg      = (config.inactive_statusline and c.bg) or c.editor.ui.statusline.nc.bg,
            sp      = (config.inactive_statusline and nil) or nil,
        },
        -- tab pages line, not active tab page label
        TabLine = {
            bg = c.editor.ui.tabline.bg,
            fg = c.editor.ui.tabline.fg,
        },
        -- tab pages line, where there are no labels
        TabLineFill = {
            bg = c.editor.ui.tabline.fill,
            fg = c.editor.ui.tabline.fg,
        },
        -- tab pages line, active tab page label
        TabLineSel = {
            bg = c.editor.ui.tabline.selected.bg,
            fg = c.editor.ui.tabline.selected.fg,
        },
        -- |hit-enter| prompt and yes/no questions
        Question = {
            fg = c.fg
        },
        -- Visual mode selection
        Visual = {
            fg = c.editor.visual.fg,
            bg = c.editor.visual.bg
        },
        -- Visual mode selection when vim is "Not Owning the Selection".
        VisualNOS = {
            fg = c.editor.visual.fg,
            bg = c.editor.visual.bg
        },
        -- 'showmode' message (e.g., "-- INSERT -- ")
        ModeMsg = {
            fg = c.fg,
            style = "bold"
        },
        -- Area for messages and cmdline
        MsgArea = {
            fg = c.fg
        },
        -- |more-prompt|
        MoreMsg = {
            fg = c.fg
        },
        -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        QuickFixLine = {
            bg = c.bg,
            style = "bold"
        },
        -- quickfixLine
        qfLineNr = {
            fg = c.editor.linenr
        },
        qfFileName = {
            fg = c.editor.ui.directory
        },
        -- (preferred) text that stands out, HTML links
        Underlined = {
            style = "underline"
        },
        Bold = {
            style = "bold"
        },
        Italic = {
            style = "italic"
        },
    }
    return tb
end

function M.setup(config, colors)
    local theme = {}
    local defer = {}
    local c = colors

    -- neovim base
    theme = extend(theme, M.base(config, c))
    theme = extend(theme, M.diff(config, c))
    theme = extend(theme, M.spell(config, c))
    theme = extend(theme, M.lsp(config, c))
    theme = extend(theme, M.diagnostics(config, c))
    theme = extend(theme, M.markup(config, c))
    theme = extend(theme, M.debug(config, c))

    -- neovim plugins
    theme = extend(theme, M.plugins(config, c))

    -- lualine and other hl's that should be highlighted later
    defer = extend(defer, M.lualine(config, c))

    return theme, defer, colors
end

return M
