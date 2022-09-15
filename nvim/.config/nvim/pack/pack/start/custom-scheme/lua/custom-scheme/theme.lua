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

function M.plugins(config, c)
    local tb = {}
    local function telescope(config, c)
        local t = {}
        t = {
            -- Telescope
            TelescopeBorder = {
                fg = c.black2,
            },
            TelescopeNormal = {
                fg = c.green2,
            },
            TelescopePromptPrefix = {
                fg = c.blue,
            },
            TelescopeSelection = {
                fg = c.cyan,
                bg = c.green2,
            },
            TelescopeMatching = {
                fg = c.magenta,
            },
        }
        return t
    end
    local function treesitter(config, c)
        local t = {}

        local error = {
            "TSError"           -- For syntax/parser errors.
        }

	    local punctuation = {
            "TSPunctDelimiter", -- For delimiters ie: `.`
            "TSPunctBracket",   -- For brackets and parens.
            "TSPunctSpecial"    -- For special punctutations
        }

	    local constants = {
            "TSConstant",       -- For constants
            "TsConstBuiltin",   -- For constant that are built in the language: `nil` in Lua.
            "TSConstMacro"      -- For constants that are defined by macros: `NULL` in C.
        }


	    local constructors = {
            "TSConstructor"     -- For constructor calls and definitions: `= { }` in Lua
        }

	    local boolean = {
            "TSBoolean"
        }

	    local functions = {
            "TSFunction",       -- For function (calls and definitions).
            "TSFuncBuiltin",    -- For builtin functions: `table.insert` in Lua.
            "TSFuncMacro"       -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        }

	    local methods = {
            "TSMethod"          -- For method calls and definitions.
        }

	    local fields = {
            "TSField",          -- For fields.
            "TSProperty"        -- Same as `TSField`.
        }

	    local number = {
            "TSNumber",
            "TSFloat"
        }

	    local parameters = {
            "TSParameter",          -- For parameters of a function.
            "TSParameterReference"  -- For references to parameters of a function.
        }

	    local operators = {
            "TSOperator"            -- For any operator: `+`, but also `->` and `*` in C.
        }

	    local forwords = {
            "TSConditional",        -- For keywords related to conditionnals.
            "TSRepeat"              -- For keywords related to loops.
        }

	    local keyword = {
            "TSKeyword",            -- For keywords that don't fall in previous categories.
            "TSKeywordFunction",    -- For keywords used to define a fuction.
            "TSKeywordOperator"     -- For keywords used to define a fuction.
        }

	    local types = {
            "TSType",               -- For types.
            "TSTypeBuiltin"         -- For builtin types.
        }

	    local labels = {
            "TSLabel"               -- For labels: `label:` in C and `:label:` in Lua.
        }

	    local namespaces = {
            "TSNamespace"           -- For identifiers referring to modules and namespaces.
        }

	    local includes = {
            "TSInclude"             -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        }

	    local variables = {
            "TSVariable",           -- Any variable name that does not have another highlight.
            "TSVariableBuiltin"     -- Variable names that are defined by the languages, like `this` or `self`.
        }

	    local tags = {
            "TSTag",                -- Tags like html tag names.
            "TSTagDelimiter"        -- Tag delimiter like `<` `>` `/`
        }

	    local title = {
            "TSTitle"               -- Text that is part of a title.
        }

	    local text = {
            "TSText",               -- For strings considered text in a markup language.
            "TSTextReference",
            "TSStrong",
            "TSEmphasis",           -- For text to be represented with emphasis.
            "TSUnderline",          -- For text to be represented with an underline.
            "TSLiteral",            -- Literal text.
            "TSURI"                 -- Any URI like a link or email.
        }

        t = group(t, error, {
                bg = c.black2,
                fg = c.fg,
        })
        t = group(t, punctuation, {
            fg = c.grey2
        })
        t = group(t, constructors, {
            fg = c.green
        })
        t = group(t, boolean, {
            fg = c.red
        })
        t = group(t, functions, {
            fg = c.green,
            style = config.function_style
        })
        t = group(t, methods, {
            fg = c.green2,
            style = "italic"
        })
        t = group(t, fields, {
            fg = c.blue,
        })
        t = group(t, number, {
            fg = c.yellow,
        })
        t = group(t, parameters, {
            fg = c.cyan,
        })
        t = group(t, operators, {
            fg = c.grey,
        })
        t = group(t, forwords, {
            fg = c.blue,
        })
        t = group(t, keyword, {
            fg = c.magenta,
            style = config.keyword_style
        })
        t = group(t, labels, {
            fg = c.magenta2,
        })
        t = group(t, types, {
            fg = c.green,
        })
        t = group(t, namespaces, {
            fg = c.grey,
        })
        t = group(t, includes, {
            fg = c.magenta,
        })
        t = group(t, variables, {
            fg = c.fg,
            style = config.variable_style
        })
        t = group(t, tags, {
            fg = c.cyan2,
        })
        t = group(t, title, {
            fg = c.green2,
        })
        t = group(t, text, {
            fg = c.fg,
        })
        t = group(t, constants, {
            fg = c.red2
        })

        t["TSConstBuiltin"] = {
            fg = c.blue
        }

        return t
    end
    local function lsp(config, c)
        local t = {}
        t = {
            -- LspTrouble
            LspTroubleText = {
                fg = c.editor.error.fg
            },
            LspTroubleCount = {
                fg = c.magenta,
                bg = c.grey
            },
            LspTroubleNormal = {
                fg = c.editor.ui.sidebar.fg,
                bg = c.editor.ui.sidebar.bg
            },
            -- LspSaga
            DiagnosticWarning = {
                link = "DiagnosticWarn"
            },
            DiagnosticInformation = {
                link = "DiagnosticInfo"
            },
            LspFloatWinNormal = {
                bg = c.black
            },
            LspFloatWinBorder = {
                fg = c.black2
            },
            LspSagaBorderTitle = {
                fg = c.cyan
            },
            LspSagaHoverBorder = {
                fg = c.blue
            },
            LspSagaRenameBorder = {
                fg = c.magenta
            },
            LspSagaDefPreviewBorder = {
                fg = c.magenta
            },
            LspSagaCodeActionBorder = {
                fg = c.blue
            },
            LspSagaFinderSelection = {
                fg = c.editor.visual.bg
            },
            LspSagaCodeActionTitle = {
                fg = c.cyan2
            },
            LspSagaCodeActionContent = {
                fg = c.magenta2
            },
            LspSagaSignatureHelpBorder = {
                fg = c.red
            },
            ReferencesCount = {
                fg = c.magenta2
            },
            DefinitionCount = {
                fg = c.magenta2
            },
            DefinitionIcon = {
                fg = c.blue
            },
            ReferencesIcon = {
                fg = c.blue
            },
            TargetWord = {
                fg = c.cyan
            },
        }
        return t
    end
    local function cmp(config, c)
        local t = {}
        t = {
            -- Cmp
            CmpItemMenu = {
                fg = c.black,
            },
            CmpItemAbbr = {
                fg = c.magenta,
            },
            CmpItemAbbrMatch = {
                fg = c.magenta2,
            },
            CmpItemAbbrMatchFuzzy = {
                fg = c.magenta2,
            },
            CmpItemKind = {
                fg = c.black2,
            },
        }
        return t
    end
    local function neogit(config, c)
        local t = {}
        t = {
            -- Neogit
            NeogitBranch = {
                fg = c.magenta
            },
            NeogitRemote = {
                fg = c.magenta2
            },
            NeogitHunkHeader = {
                fg = c.fg,
                bg = c.bg,
            },
            NeogitHunkHeaderHighlight = {
                fg = c.blue,
                bg = c.grey,
            },
            NeogitDiffContextHighlight = {
                fg = c.none,
                bg = c.grey,
            },
            NeogitDiffDeleteHighlight = {
                fg = c.fg,
                bg = c.editor.diff.delete
            },
            NeogitDiffAddHighlight = {
                fg = c.fg,
                bg = c.editor.diff.add
            },
        }
        return t
    end
    local function nvimtree(config, c)
        local t = {}
        t = {
            -- NvimTree
            NvimTreeNormal = {
                fg = c.editor.ui.sidebar.fg,
                bg = c.editor.ui.sidebar.bg,
            },
            NvimTreeNormalNC = {
                fg = c.editor.ui.sidebar.fg,
                bg = c.editor.ui.sidebar.bg,
            },
            NvimTreeRootFolder = {
                fg = c.blue,
                style = "bold"
            },
            NvimTreeGitDirty = {
                fg = c.editor.diff.change
            },
            NvimTreeGitNew = {
                fg = c.editor.diff.add
            },
            NvimTreeGitDeleted = {
                fg = c.editor.diff.delete
            },
            NvimTreeSpecialFile = {
                fg = c.magenta2,
                style = "underline"
            },
            NvimTreeIndentMarker = {
                fg = c.grey
            },
            NvimTreeImageFile = {
                fg = c.editor.ui.sidebar.fg,
            },
            NvimTreeSymlink = {
                fg = c.blue
            },
            -- NvimTreeFolderName= {
            --     fg = c.fg_float
            -- },
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
                fg = c.yellow
            },
            diffNewFile = {
                fg = c.yellow2
            },
            diffFile = {
                fg = c.blue
            },
            diffLine = {
                fg = c.grey
            },
            diffIndexLine = {
                fg = c.magenta
            },
        }
        return t
    end
    local function ale(config, c)
        local t = {}
        t = {
            ALEErrorSign = {
                fg = c.editor.error.fg
            },
            ALEWarningSign = {
                fg = c.editor.warning.fg
            },
        }
        return t
    end
    local function gitsigns(config, c)
        local t = {}
        t = {
            -- GitSigns
            -- diff mode: Added line |diff.txt|
            GitSignsAdd = {
                fg = c.editor.diff.add
            },
            -- diff mode: Changed line |diff.txt|
            GitSignsChange = {
                fg = c.editor.diff.change
            },
            -- diff mode: Deleted line |diff.txt|
            GitSignsDelete = {
                fg = c.editor.diff.delete
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
                fg = c.green
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

    tb = extend(tb, treesitter(config, c))
    tb = extend(tb, telescope(config, c))
    tb = extend(tb, lsp(config, c))
    tb = extend(tb, cmp(config, c))
    tb = extend(tb, neogit(config, c))
    tb = extend(tb, nvimtree(config, c))
    tb = extend(tb, diff(config, c))
    tb = extend(tb, ale(config, c))
    tb = extend(tb, gitsigns(config, c))
    tb = extend(tb, neovim(config, c))

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
          c = { bg = c.editor.ui.statusline.bg, fg = c.fg },
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
          a = { bg = c.yellow, fg = c.black2 },
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

    if config.hide_inactive_statusline then
        local inactive = {
            style = "underline",
            bg = c.bg,
            fg = c.bg,
            sp = c.editor.ui.border
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
            fg = c.fg,
            bg = c.black2,
            style = "bold"
        },
        htmlH2 = {
            fg = c.fg,
            bg = c.black2,
            style = "bold"
        },
        markdownh1 = {
            fg = c.fg,
            bg = c.black2,
            style = "bold"
        },
        markdownh2 = {
            fg = c.fg,
            bg = c.black2,
            style = "bold"
        },
        markdownh3 = {
            fg = c.fg,
            bg = c.black2,
            style = "bold"
        },
        markdownh4 = {
            fg = c.fg,
            bg = c.black2,
            style = "bold"
        },
        markdownh5 = {
            fg = c.fg,
            bg = c.black2,
            style = "bold"
        },
        markdownCodeDelimiter = {
            bg = c.grey2,
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
            fg = c.editor.error.fg
        },
        DiagnosticWarn = {
            fg = c.editor.warning.fg
        },
        DiagnosticInfo = {
            fg = c.editor.info.fg
        },
        DiagnosticHint = {
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
            style = "undercurl",
            sp = c.editor.error.fg
        },
        -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineWarn = {
            style = "undercurl",
            sp = c.editor.error.fg
        },
        -- Used to underline "Information" diagnostics
        DiagnosticUnderlineInfo = {
            style = "undercurl",
            sp = c.editor.info.fg
        },
        -- Used to underline "Hint" diagnostics
        DiagnosticUnderlineHint = {
            style = "undercurl",
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
            sp = c.blue2,
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
            bg = c.editor.diff.add
        },
        -- Changed line
        DiffChange = {
            bg = c.editor.diff.change
        },
        -- Deleted line
        DiffDelete = {
            bg = c.editor.diff.delete
        },
        -- Changed text within a line
        DiffText = {
            bg = c.editor.diff.text
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
            fg = c.green,
            bg = c.black2,
        },
        -- placeholder characters substituted for concealed text
        Conceal = {
            fg = c.white2
        },
        -- the column separating vertically split windows
        VertSplit = {
            fg = c.editor.ui.border
        },
        -- function name, also methods for classes
        Function = {
            fg = c.cyan2,
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
            fg = c.error
        },
        -- Boolean
        Boolean = {
            fg = c.magenta2,
            style = config.comment_style
        },
        --  a character constant: 'c', '\n'
        Character = {
            fg = c.white2
        },
        -- Comments
        Comment = {
            fg = c.editor.comment,
            style = config.comment_style
        },
        Conditional = {
            fg = c.green,
        },
        -- (preferred) any constant
        Constant = {
            fg = c.magenta
        },
        Float = {
            fg = c.magenta
        },
        -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        Search = {
            bg = c.black,
            fg = c.cyan
        },
        -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        IncSearch = {
            bg = c.black,
            fg = c.cyan
        },
        -- |:substitute| replacement text highlighting
        Substitute = {
            bg = c.red,
            fg = c.black
        },
        Number = {
            fg = c.cyan
        },
        Define = {
            fg = c.green
        },
        Delimiter = {
            fg = c.green
        },
        -- directory names
        Directory = {
            fg = c.magenta
        },
        -- line used for closed folds
        Folded = {
            fg = c.grey,
        },
        -- 'foldcolumn'
        FoldColumn = {
            fg = c.grey,
        },
        -- any variable name
        Identifier = {
            fg = c.magenta2,
            style = config.variable_style
        },
        Include = {
            fg = c.green,
        };
        --  any other keyword
        Keyword = {
            fg = c.magenta,
            style = config.keyword_style
        },
        Label = {
            fg = c.green,
            style = config.keyword_style
        },
        -- "sizeof", "+", "*", etc.
        Operator = {
            fg = c.blue2
        },
        -- (preferred) generic Preprocessor
        PreProc = {
            fg = c.green
        },
        Repeat = {
            fg = c.blue2
        };
        -- (preferred) any statement
        Statement = {
            fg = c.green
        },
        -- Keywords that affect how a variable is stored: `static`, `comptime`, `extern`,
        StorageClass = {
            fg = c.green
        },
        --   a string constant: "this is a string"
        String = {
            fg = c.white2
        },
        Structure = {
            fg = c.green
        },
        Tag = {
            fg = c.magenta
        },
        -- titles for output from ":set all", ":autocmd" etc.
        Title = {
            fg = c.magenta,
            style = "bold"
        },
        -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Todo = {
            fg = c.black2
        },
        -- (preferred) int, long, char, etc.
        Type = {
            fg = c.green
        },
        -- (preferred) int, long, char, etc.
        Typedef = {
            fg = c.green
        },
        -- screen-column at the cursor, when 'cursorcolumn' is set.
        CursorColumn = {
            fg = (config.columnline and c.white)
                 or c.none
        },
        -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        LineNr = {
            fg = c.grey
        },
        -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        CursorLineNr = {
            fg = c.red2
        },
        Line = {
            fg = c.blue2
        },
        -- column where |signs| are displayed
        SignColumn = {
            bg = config.transparent and c.none
                 or c.bg,
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
            fg = c.white2
        },
        -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        MatchParen = {
            fg = c.red2,
            style = "bold"
        },
        -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        NonText = {
            fg = c.black2
        },
        -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Whitespace = {
            fg = c.black2
        },
        -- Popup menu: normal item.
        Pmenu = {
            bg = c.editor.ui.popmenu.bg,
            fg = c.editor.ui.popmenu.fg,
        },
        -- Popup menu: selected item.
        PmenuSel = {
            bg = c.editor.ui.popmenu.sel,
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
            bg = c.red
        },
        -- (preferred) any special symbol
        Special = {
            fg = c.magenta
        },
        -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpecialKey = {
            fg = c.red2
        },
        SpecialChar = {
            fg = c.red2
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
            bg = c.editor.ui.tabline.bg,
            fg = c.editor.ui.tabline.fg,
        },
        -- tab pages line, active tab page label
        TabLineSel = {
            bg = c.editor.ui.tabline.sel.bg,
            fg = c.editor.ui.tabline.sel.fg,
        },
        -- |hit-enter| prompt and yes/no questions
        Question = {
            fg = c.green
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
            fg = c.red
        },
        qfFileName = {
            fg = c.blue
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
