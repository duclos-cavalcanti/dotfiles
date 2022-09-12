local M = {}

local function extend(tb, ext)
	for k, v in pairs(ext) do
        tb[k] = v
	end

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
          a = { bg = c.primary, fg = c.black2 },
          b = { bg = c.black, fg = c.fg },
          c = { bg = c.alias.ui.statusline.bg, fg = c.fg },
        },
        insert = {
          a = { bg = c.tertiary, fg = c.black2 },
          b = { bg = c.alias.ui.statusline.bg, fg = c.fg },
        },
        command = {
          a = { bg = c.yellow, fg = c.black2 },
          b = { bg = c.alias.ui.statusline.bg, fg = c.fg },
        },
        visual = {
          a = { bg = c.magenta, fg = c.black2 },
          b = { bg = c.alias.ui.statusline.bg, fg = c.fg },
        },
        replace = {
          a = { bg = c.secondary, fg = c.black2 },
          b = { bg = c.alias.ui.statusline.bg, fg = c.fg },
        },
        inactive = {
          a = { bg = c.alias.ui.statusline.bg, fg = c.white2 },
          b = { bg = c.alias.ui.statusline.bg, fg = c.white2, gui = "bold" },
          c = { bg = c.alias.ui.statusline.bg, fg = c.white2 },
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
            sp = c.border
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
            bg = c.bg_sidebar
        },
        -- used for breakpoint colors in terminal-debug
        debugBreakpoint = {
            bg = c.info,
            fg = c.info
        },
    }

    return tb
end

function M.markup(config, c)
    local tb = {}
    tb = {
        htmlH1 = {
            fg = c.magenta,
            style = "bold"
        },
        htmlH2 = {
            fg = c.blue,
            style = "bold"
        },

        mkdCodeDelimiter = {
            bg = c.terminal_black,
            fg = c.fg
        },
        mkdCodeStart = {
            fg = c.grey,
            style = "bold"
        },
        mkdCodeEnd = {
            fg = c.grey,
            style = "bold"
        },

        markdownHeadingDelimiter = {
            fg = c.yellow2,
            style = "bold"
        },
        markdownCode = {
            fg = c.grey
        },
        markdownCodeBlock = {
            fg = c.grey
        },
        markdownH1 = {
            fg = c.primary,
            style = "bold"
        },
        markdownH2 = {
            fg = c.primary,
            style = "bold"
        },
        markdownLinkText = {
            fg = c.blue,
            style = "underline"
        },
    }
    return tb
end

function M.diagnostics(config, c)
    local tb = {}
    tb = {
        -- Base highlight groups
        -- Diagnostic highlights link to this by default
        DiagnosticError = {
            fg = c.alias.error.fg
        },
        DiagnosticWarn = {
            fg = c.alias.warning.fg
        },
        DiagnosticInfo = {
            fg = c.alias.info.fg
        },
        DiagnosticHint = {
            fg = c.alias.hint.fg
        },
        -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextError = {
            bg = c.none,
            fg = c.alias.error.fg
        },
        -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextWarn = {
            bg = c.none,
            fg = c.alias.warning.fg
        },
        -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextInfo = {
            bg = c.none,
            fg = c.alias.info.fg
        },
        -- Used for "Hint" diagnostic virtual text
        DiagnosticVirtualTextHint = {
            bg = c.none,
            fg = c.alias.hint.fg
        },
        -- Used to underline "Error" diagnostics
        DiagnosticUnderlineError = {
            style = "undercurl",
            sp = c.alias.error.fg
        },
        -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineWarn = {
            style = "undercurl",
            sp = c.alias.error.fg
        },
        -- Used to underline "Information" diagnostics
        DiagnosticUnderlineInfo = {
            style = "undercurl",
            sp = c.alias.info.fg
        },
        -- Used to underline "Hint" diagnostics
        DiagnosticUnderlineHint = {
            style = "undercurl",
            sp = c.alias.hint.fg
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
            bg = c.faded
        },
        -- used for highlighting "read" references
        LspReferenceRead = {
            bg = c.faded
        },
        -- used for highlighting "write" references
        LspReferenceWrite = {
            bg = c.faded
        },
        LspSignatureActiveParameter = {
            fg = c.yellow2
        },
        LspCodeLens = {
            fg = c.comment
        },
    }

    return tb
end


function M.spell(config, c)
    local tb = {}
    tb = {
        -- Word that is not recognized by the spellchecker.
        SpellBad = {
            sp = c.alias.error.fg,
            style = "undercurl"
        },
        -- Word that should start with a capital.
        SpellCap = {
            sp = c.alias.warning.fg,
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
            bg = c.alias.diff.add
        },
        -- Changed line
        DiffChange = {
            bg = c.alias.diff.change
        },
        -- Deleted line
        DiffDelete = {
            bg = c.alias.diff.delete
        },
        -- Changed text within a line
        DiffText = {
            bg = c.alias.diff.text
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
            fg = c.green2,
            bg = c.black2,
        },
        -- placeholder characters substituted for concealed text
        Conceal = {
            fg = c.white2
        },
        -- the column separating vertically split windows
        VertSplit = {
            fg = c.alias.ui.border
        },
        -- function name, also methods for classes
        Function = {
            fg = c.cyan2,
            style = config.function_style
        },
        -- (preferred) any erroneous construct
        Error = {
            fg = c.alias.error.fg
        },
        -- error messages on the command line
        ErrorMsg = {
            bg = c.alias.error.bg,
            fg = c.alias.error.fg
        },
        -- warning messages
        WarningMsg = {
            fg = c.alias.warning.fg,
            bg = c.alias.warning.bg,
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
            fg = c.alias.comment,
            style = config.comment_style
        },
        Conditional = {
            fg = c.green2,
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
            bg = c.red2,
            fg = c.black
        },
        Number = {
            fg = c.cyan
        },
        Define = {
            fg = c.green2
        },
        Delimiter = {
            fg = c.green2
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
            fg = c.green2,
        };
        --  any other keyword
        Keyword = {
            fg = c.magenta,
            style = config.keyword_style
        },
        Label = {
            fg = c.green2,
            style = config.keyword_style
        },
        -- "sizeof", "+", "*", etc.
        Operator = {
            fg = c.blue2
        },
        -- (preferred) generic Preprocessor
        PreProc = {
            fg = c.green2
        },
        Repeat = {
            fg = c.blue2
        };
        -- (preferred) any statement
        Statement = {
            fg = c.green2
        },
        -- Keywords that affect how a variable is stored: `static`, `comptime`, `extern`,
        StorageClass = {
            fg = c.green2
        },
        --   a string constant: "this is a string"
        String = {
            fg = c.white2
        },
        Structure = {
            fg = c.green2
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
            fg = c.green2
        },
        -- (preferred) int, long, char, etc.
        Typedef = {
            fg = c.green2
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
            fg = c.red
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
            bg = config.colorcolumn and c.alias.ui.colorcolumn
            or c.none
        },
        -- screen-line at the cursor, when 'cursorline' is set.
        CursorLine = {
            bg = config.cursorline and c.alias.ui.cursorline
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
            fg = c.red,
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
            bg = c.alias.ui.popmenu.bg,
            fg = c.alias.ui.popmenu.fg,
        },
        -- Popup menu: selected item.
        PmenuSel = {
            bg = c.alias.ui.popmenu.sel,
        },
        -- Popup menu: scrollbar.
        PmenuSbar = {
            bg = c.alias.ui.popmenu.sbar.bg,
            fg = c.alias.ui.popmenu.sbar.fg,
        },
        -- Popup menu: Thumb of the scrollbar.
        PmenuThumb = {
            bg = c.alias.ui.popmenu.thumb.bg,
            fg = c.alias.ui.popmenu.thumb.fg,
        },
        -- current match in 'wildmenu' completion
        WildMenu = {
            bg = c.red2
        },
        -- (preferred) any special symbol
        Special = {
            fg = c.magenta
        },
        -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpecialKey = {
            fg = c.red
        },
        SpecialChar = {
            fg = c.red
        },
        SpecialComment = {
            link = "Comment"
        },
        -- status line of current window
        StatusLine = {
            fg = c.alias.ui.statusline.fg,
            bg = c.alias.ui.statusline.bg,
        },
        -- status lines of not-current windows
        -- Note: if this is equal to "StatusLine"
        -- Vim will use "^^^" in the status line of the current window.
        StatusLineNC = {
            style   = (config.inactive_statusline and "italic") or nil,
            fg      = (config.inactive_statusline and c.bg) or c.alias.ui.statusline.nc.fg,
            bg      = (config.inactive_statusline and c.bg) or c.alias.ui.statusline.nc.bg,
            sp      = (config.inactive_statusline and nil) or nil,
        },
        -- tab pages line, not active tab page label
        TabLine = {
            bg = c.alias.ui.tabline.bg,
            fg = c.alias.ui.tabline.fg,
        },
        -- tab pages line, where there are no labels
        TabLineFill = {
            bg = c.alias.ui.tabline.bg,
            fg = c.alias.ui.tabline.fg,
        },
        -- tab pages line, active tab page label
        TabLineSel = {
            bg = c.alias.ui.tabline.sel.bg,
            fg = c.alias.ui.tabline.sel.fg,
        },
        -- |hit-enter| prompt and yes/no questions
        Question = {
            fg = c.green2
        },
        -- Visual mode selection
        Visual = {
            fg = c.green2,
            bg = c.black2
        },
        -- Visual mode selection when vim is "Not Owning the Selection".
        VisualNOS = {
            fg = c.black2,
            bg = c.green2,
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
            fg = c.yellow
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

function M.plugins(config, c)
    local tb = {}
    local function telescope(config, c)
        local t = {}
        t = {
            -- Telescope
            TelescopeBorder = {
                fg = c.border_highlight,
                bg = c.bg_float
            },
            TelescopeNormal = {
                fg = c.fg,
                bg = c.bg_float
            },
        }
        return t
    end
    local function treesitter(config, c)
        local t = {}
        t = {
            -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
            -- TSAnnotation        = { };
            -- (unstable) TODO: docs
            -- TSAttribute         = { };
            -- For booleans.
            -- TSBoolean           = { };
            -- For characters.
            -- TSCharacter         = { };
            -- For comment blocks.
            -- TSComment           = { };
            TSNote = {
                fg = c.bg,
                bg = c.info
            },
            TSWarning = {
                fg = c.bg,
                bg = c.warning
            },
            TSDanger = {
                fg = c.bg,
                bg = c.error
            },
            -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
            TSConstructor = {
                fg = c.magenta
            },
            -- For keywords related to conditionnals.
            -- TSConditional       = { };
            -- For constants
            -- TSConstant          = { };
            -- For constant that are built in the language: `nil` in Lua.
            -- TSConstBuiltin      = { };
            -- For constants that are defined by macros: `NULL` in C.
            -- TSConstMacro        = { };
            -- For syntax/parser errors.
            -- TSError             = { };
            -- For exception related keywords.
            -- TSException         = { };
            -- For fields.
            TSField = {
                fg = c.yellow
            },
            -- For floats.
            -- TSFloat             = { };
            -- For function (calls and definitions).
            TSFunction = {
                fg = c.primary
            },
            -- For builtin functions: `table.insert` in Lua.
            -- TSFuncBuiltin       = { };
            -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
            -- TSFuncMacro         = { };
            -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
            -- TSInclude           = { };
            -- For keywords that don't fall in previous categories.
            TSKeyword = {
                fg = c.magenta,
                style = config.keyword_style
            },
            -- For keywords used to define a fuction.
            TSKeywordFunction = {
                fg = c.magenta,
                style = config.functionStyle
            },
            -- For labels: `label:` in C and `:label:` in Lua.
            TSLabel = {
                fg = c.tertiary
            },
            -- For method calls and definitions.
            -- TSMethod            = { };
            -- For identifiers referring to modules and namespaces.
            -- TSNamespace         = { };
            -- TODO: docs
            -- TSNone              = { };
            -- TSNumber = {
            --     fg = c.cyan
            -- },
            -- For any operator: `+`, but also `->` and `*` in C.
            TSOperator = {
                fg = c.secondary
            },
            -- For parameters of a function.
            TSParameter = {
                fg = c.fg
            },
            -- For references to parameters of a function.
            -- TSParameterReference= { };
            -- Same as `TSField`.
            TSProperty = {
                fg = c.magenta2
            },
            -- Same as `TSField`.
            luaTSProperty = {
                fg = c.secondary
            },
            -- For delimiters ie: `.`
            TSPunctDelimiter = {
                fg = c.cyan2
            },
            -- For brackets and parens.
            TSPunctBracket = {
                fg = c.cyan2
            },
            -- For special punctutation that does not fall in the catagories before.
            TSPunctSpecial = {
                fg = c.cyan2
            },
            -- For keywords related to loops.
            -- TSRepeat            = { };
            -- For strings.
            -- TSString            = { };
            -- For regexes.
            TSStringRegex = {
                fg = c.primary
            },
            -- For escape characters within a string.
            TSStringEscape = {
                fg = c.magenta
            },
            -- For identifiers referring to symbols or atoms.
            -- TSSymbol            = { };
            -- For types.
            -- TSType              = { };
            -- For builtin types.
            -- TSTypeBuiltin       = { };
            -- Any variable name that does not have another highlight.
            TSVariable = {
                style = config.variableStyle
            },
            -- Variable names that are defined by the languages, like `this` or `self`.
            TSVariableBuiltin = {
                fg = c.secondary
            },
            -- Tags like html tag names.
            -- TSTag               = { };
            -- Tag delimiter like `<` `>` `/`
            -- TSTagDelimiter      = { };
            -- For strings considered text in a markup language.
            -- TSText              = { };
            TSTextReference = {
                fg = c.grey
            },
            -- For text to be represented with emphasis.
            -- TSEmphasis          = { };
            -- For text to be represented with an underline.
            -- TSUnderline         = { };
            -- For strikethrough text.
            -- TSStrike            = { };
            -- Text that is part of a title.
            -- TSTitle             = { };
            -- Literal text.
            -- TSLiteral           = { };
            -- Any URI like a link or email.
            -- TSURI               = { };
        }
        return t
    end
    local function lsp(config, c)
        local t = {}
        t = {
            -- LspTrouble
            LspTroubleText = {
                fg = c.error
            },
            LspTroubleCount = {
                fg = c.magenta,
                bg = c.faded
            },
            LspTroubleNormal = {
                fg = c.fg_sidebar,
                bg = c.bg_sidebar
            },
            -- LspSaga
            DiagnosticWarning = {
                link = "DiagnosticWarn"
            },
            DiagnosticInformation = {
                link = "DiagnosticInfo"
            },
            LspFloatWinNormal = {
                bg = c.bg_float
            },
            LspFloatWinBorder = {
                fg = c.border_highlight
            },
            LspSagaBorderTitle = {
                fg = c.cyan
            },
            LspSagaHoverBorder = {
                fg = c.primary
            },
            LspSagaRenameBorder = {
                fg = c.tertiary
            },
            LspSagaDefPreviewBorder = {
                fg = c.tertiary
            },
            LspSagaCodeActionBorder = {
                fg = c.primary
            },
            LspSagaFinderSelection = {
                fg = c.bg_visual
            },
            LspSagaCodeActionTitle = {
                fg = c.cyan2
            },
            LspSagaCodeActionContent = {
                fg = c.magenta2
            },
            LspSagaSignatureHelpBorder = {
                fg = c.secondary
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
            CmpDocumentation = {
                fg = c.fg,
                bg = c.bg_float
            },
            CmpDocumentationBorder = {
                fg = c.border_highlight,
                bg = c.bg_float
            },

            CmpItemAbbr = {
                fg = c.fg,
                bg = c.none
            },
            CmpItemAbbrDeprecated = {
                bg = c.none,
                fg = c.faded,
                style = "strikethrough" },
            CmpItemAbbrMatch = {
                fg = c.cyan2,
                bg = c.none
            },
            CmpItemAbbrMatchFuzzy = {
                fg = c.cyan2,
                bg = c.none
            },

            CmpItemKindDefault = {
                fg = c.grey,
                bg = c.none
            },
            CmpItemMenu = {
                fg = c.comment,
                bg = c.none
            },

            CmpItemKindKeyword = {
                fg = c.cyan,
                bg = c.none
            },

            CmpItemKindVariable = {
                fg = c.magenta,
                bg = c.none
            },
            CmpItemKindConstant = {
                fg = c.magenta,
                bg = c.none
            },
            CmpItemKindReference = {
                fg = c.magenta,
                bg = c.none
            },
            CmpItemKindValue = {
                fg = c.magenta,
                bg = c.none
            },

            CmpItemKindFunction = {
                fg = c.primary,
                bg = c.none
            },
            CmpItemKindMethod = {
                fg = c.primary,
                bg = c.none
            },
            CmpItemKindConstructor = {
                fg = c.primary,
                bg = c.none
            },

            CmpItemKindClass = {
                fg = c.yellow2,
                bg = c.none
            },
            CmpItemKindInterface = {
                fg = c.yellow2,
                bg = c.none
            },
            CmpItemKindStruct = {
                fg = c.yellow2,
                bg = c.none
            },
            CmpItemKindEvent = {
                fg = c.yellow2,
                bg = c.none
            },
            CmpItemKindEnum = {
                fg = c.yellow2,
                bg = c.none
            },
            CmpItemKindUnit = {
                fg = c.yellow2,
                bg = c.none
            },

            CmpItemKindModule = {
                fg = c.yellow,
                bg = c.none
            },

            CmpItemKindProperty = {
                fg = c.tertiary,
                bg = c.none
            },
            CmpItemKindField = {
                fg = c.tertiary,
                bg = c.none
            },
            CmpItemKindTypeParameter = {
                fg = c.tertiary,
                bg = c.none
            },
            CmpItemKindEnumMember = {
                fg = c.tertiary,
                bg = c.none
            },
            CmpItemKindOperator = {
                fg = c.tertiary,
                bg = c.none
            },
            CmpItemKindSnippet = {
                fg = c.cyan2,
                bg = c.none
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
                bg = c.alias.diff.delete
            },
            NeogitDiffAddHighlight = {
                fg = c.fg,
                bg = c.alias.diff.add
            },
        }
        return t
    end
    local function nvimtree(config, c)
        local t = {}
        t = {
            -- NvimTree
            NvimTreeNormal = {
                fg = c.alias.ui.sidebar.fg,
                bg = c.alias.ui.sidebar.bg,
            },
            NvimTreeNormalNC = {
                fg = c.alias.ui.sidebar.fg,
                bg = c.alias.ui.sidebar.bg,
            },
            NvimTreeRootFolder = {
                fg = c.primary,
                style = "bold"
            },
            NvimTreeGitDirty = {
                fg = c.alias.diff.change
            },
            NvimTreeGitNew = {
                fg = c.alias.diff.add
            },
            NvimTreeGitDeleted = {
                fg = c.alias.diff.delete
            },
            NvimTreeSpecialFile = {
                fg = c.magenta2,
                style = "underline"
            },
            NvimTreeIndentMarker = {
                fg = c.grey
            },
            NvimTreeImageFile = {
                fg = c.alias.ui.sidebar.fg,
            },
            NvimTreeSymlink = {
                fg = c.primary
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
                fg = c.alias.diff.add
            },
            diffRemoved = {
                fg = c.alias.diff.delete
            },
            diffChanged = {
                fg = c.alias.diff.change
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
                fg = c.error
            },
            ALEWarningSign = {
                fg = c.warning
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
                fg = c.alias.diff.add
            },
            -- diff mode: Changed line |diff.txt|
            GitSignsChange = {
                fg = c.alias.diff.change
            },
            -- diff mode: Deleted line |diff.txt|
            GitSignsDelete = {
                fg = c.alias.diff.delete
            },
        }
        return t
    end
    local function neovim(config, c)
        local t = {}
        t = {
            -- NeoVim
            healthError = {
                fg = c.error
            },
            healthSuccess = {
                fg = c.green2
            },
            healthWarning = {
                fg = c.warning
            },
        }
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

function M.setup(config, colors)
    local theme = {}
    local defer = {}
    local c = colors

    c.alias = {
        comment     = c.cyan2,
        error       = {
            bg = c.black,
            fg = c.red2,
        },
        warning     = {
            bg = c.blue2,
            fg = c.white,
        },
        hint     = {
            fg = c.white2,
        },
        info     = {
            fg = c.fg,
        },
        ui          = {
            border      = c.green, -- split, vertsplit
            colorcolumn = c.black2,
            cursorline  = c.green,
            statusline  = {
                bg = c.black2,
                fg = c.green2,
                nc = {
                    bg = c.black2,
                    fg = c.white2,
                }
            },
            tabline  = {
                bg = c.green,
                fg = c.green2,
                sel = {
                    bg = c.red,
                    fg = c.green2,
                }
            },
            popmenu     = {
                bg = c.black,
                fg = c.magenta2,
                sel = c.green,
                sbar = {
                    bg = c.green,
                    c.magenta
                },
                thumb = {
                    bg = c.white2,
                    fg = c.blue2
                }
            },
            sidebar  = {
                bg = c.black2,
                fg = c.green2,
                nc = {
                    bg = c.black2,
                    fg = c.white2,
                }
            },
        },
        diff    = {
            add     = c.green2,
            change  = c.blue2,
            delete  = c.red2,
            text    = c.white2,
        }
    }

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
