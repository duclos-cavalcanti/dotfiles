local M = {}

local function extend(tb, ext)
	for k, v in pairs(ext) do
        tb[k] = v
	end

    return tb
end

function M.lualine(config, c)
    local tb = {}
    _l_ = {
        normal = {
          a = { bg = c.primary, fg = c.black2 },
          b = { bg = c.black, fg = c.fg },
          c = { bg = c.bg_statusline, fg = c.fg },
        },
        insert = {
          a = { bg = c.tertiary, fg = c.black2 },
          b = { bg = c.bg_statusline, fg = c.fg },
        },
        command = {
          a = { bg = c.yellow, fg = c.black2 },
          b = { bg = c.bg_statusline, fg = c.fg },
        },
        visual = {
          a = { bg = c.magenta, fg = c.black2 },
          b = { bg = c.bg_statusline, fg = c.fg },
        },
        replace = {
          a = { bg = c.secondary, fg = c.black2 },
          b = { bg = c.bg_statusline, fg = c.fg },
        },
        inactive = {
          a = { bg = c.bg_statusline, fg = c.faded },
          b = { bg = c.bg_statusline, fg = c.faded, gui = "bold" },
          c = { bg = c.bg_statusline, fg = c.faded },
        },
    }

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

    return tb, _l_
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
            fg = c.error
        },
        DiagnosticWarn = {
            fg = c.warning
        },
        DiagnosticInfo = {
            fg = c.info
        },
        DiagnosticHint = {
            fg = c.hint
        },
        -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextError = {
            bg = c.none,
            fg = c.error
        },
        -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextWarn = {
            bg = c.none,
            fg = c.warning
        },
        -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextInfo = {
            bg = c.none,
            fg = c.info
        },
        -- Used for "Hint" diagnostic virtual text
        DiagnosticVirtualTextHint = {
            bg = c.none,
            fg = c.hint
        },
        -- Used to underline "Error" diagnostics
        DiagnosticUnderlineError = {
            style = "undercurl",
            sp = c.error
        },
        -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineWarn = {
            style = "undercurl",
            sp = c.warning
        },
        -- Used to underline "Information" diagnostics
        DiagnosticUnderlineInfo = {
            style = "undercurl",
            sp = c.info
        },
        -- Used to underline "Hint" diagnostics
        DiagnosticUnderlineHint = {
            style = "undercurl",
            sp = c.hint
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
        -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellBad = {
            sp = c.error,
            style = "undercurl"
        },
        -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellCap = {
            sp = c.warning,
            style = "undercurl"
        },
        -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellLocal = {
            sp = c.info,
            style = "undercurl"
        },
        -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        SpellRare = {
            sp = c.hint,
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
            bg = c.diff.add
        },
        -- Changed line
        DiffChange = {
            bg = c.diff.change
        },
        -- Deleted line
        DiffDelete = {
            bg = c.diff.delete
        },
        -- Changed text within a line
        DiffText = {
            bg = c.diff.text
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
        -- placeholder characters substituted for concealed text
        Conceal = {
            fg = c.white2
        },
        -- the column separating vertically split windows
        VertSplit = {
            fg = c.border
        },
        -- function name, also methods for classes
        Function = {
            fg = c.black2,
            style = config.function_style
        },
        -- (preferred) any erroneous construct
        Error = {
            fg = c.error
        },
        -- error messages on the command line
        ErrorMsg = {
            fg = c.error
        },
        -- warning messages
        WarningMsg = {
            fg = c.white,
            bg = c.blue2
        },
        Exception = {
            fg = c.error
        },
        -- Boolean
        Boolean = {
            fg = c.magenta,
            style = config.comment_style
        },
        --  a character constant: 'c', '\n'
        Character = {
            fg = c.tertiary
        },
        -- Comments
        Comment = {
            fg = c.alias.comment,
            style = config.comment_style
        },
        SpecialComment = {
            link = "Comment"
        },
        Conditional = {
            fg = c.green2,
        },
        -- (preferred) any constant
        Constant = {
            fg = c.magenta2
        },
        Float = {
            fg = c.magenta2
        },
        -- used columns set with 'colorcolumn'
        ColorColumn = {
            bg = config.columnline and c.bg_statusline
            or c.none
        },
        -- screen-column at the cursor, when 'cursorcolumn' is set.
        CursorColumn = {
            bg = config.columnline and c.bg_statusline
                 or c.none
        },
        -- screen-line at the cursor, when 'cursorline' is set.
        CursorLine = {
            bg = config.cursorline and c.bg_statusline
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
        -- directory names
        Directory = {
            fg = c.primary
        },
        -- filler lines (~) after the end of the buffer
        EndOfBuffer = {
            fg = c.bg
        },
        -- line used for closed folds
        Folded = {
            fg = c.primary,
            bg = c.faded
        },
        -- 'foldcolumn'
        FoldColumn = {
            bg = c.bg,
            fg = c.comment
        },
        -- column where |signs| are displayed
        SignColumn = {
            bg = config.transparent and c.none
                 or c.bg,
            fg = c.faded
        },
        -- column where |signs| are displayed
        SignColumnSB = {
            bg = c.bg_sidebar,
            fg = c.faded
        },
        -- |:substitute| replacement text highlighting
        Substitute = {
            bg = c.secondary,
            fg = c.black
        },
        -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        LineNr = {
            fg = c.grey
        },
        -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        CursorLineNr = {
            fg = c.fg
        },
        -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        MatchParen = {
            fg = c.yellow2,
            style = "bold"
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
            fg = c.primary
        },
        -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        NonText = {
            fg = c.grey
        },
        FloatBorder = {
            fg = c.border_highlight,
            bg = c.bg_float
        },
        -- Popup menu: normal item.
        Pmenu = {
            bg = c.bg_popup,
            fg = c.fg
        },
        -- Popup menu: selected item.
        PmenuSel = {
            bg = c.faded
        },
        -- Popup menu: scrollbar.
        PmenuSbar = {
            bg = c.bg_popup
        },
        -- Popup menu: Thumb of the scrollbar.
        PmenuThumb = {
            bg = c.faded
        },
        -- |hit-enter| prompt and yes/no questions
        Question = {
            fg = c.primary
        },
        -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        QuickFixLine = {
            bg = c.bg_visual,
            style = "bold"
        },
        -- quickfixLine
        qfLineNr = {
            fg = c.grey
        },
        qfFileName = {
            fg = c.blue
        },
        -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        Search = {
            bg = c.bg_search,
            fg = c.fg
        },
        -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        IncSearch = {
            bg = c.yellow2,
            fg = c.black
        },
        -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpecialKey = {
            fg = c.grey
        },
        -- status line of current window
        StatusLine = {
            fg = c.fg_statusline,
            bg = c.bg_statusline
        },
        -- status lines of not-current windows
        -- Note: if this is equal to "StatusLine"
        -- Vim will use "^^^" in the status line of the current window.
        StatusLineNC = {
            style   = (config.hide_inactive_statusline and c.border) or nil,
            fg      = (config.hide_inactive_statusline and c.bg) or c.faded,
            bg      = (config.hide_inactive_statusline and c.bg) or c.bg_statusline,
            sp      = (config.hide_inactive_statusline and c.border) or nil,
        },
        -- tab pages line, not active tab page label
        TabLine = {
            bg = c.tabline.bg,
            fg = c.tabline.fg
        },
        -- tab pages line, where there are no labels
        TabLineFill = {
            bg = c.tabline.bg_fill
        },
        -- tab pages line, active tab page label
        TabLineSel = {
            fg = c.tabline.fg_sel,
            bg = c.tabline.bg_sel
        },
        -- titles for output from ":set all", ":autocmd" etc.
        Title = {
            fg = c.primary,
            style = "bold"
        },
        -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Todo = {
            bg = c.yellow,
            fg = c.bg
        },
        -- Visual mode selection
        Visual = {
            bg = c.bg_visual
        },
        -- Visual mode selection when vim is "Not Owning the Selection".
        VisualNOS = {
            bg = c.bg_visual
        },
        -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Whitespace = {
            fg = c.faded
        },
        -- current match in 'wildmenu' completion
        WildMenu = {
            bg = c.bg_visual
        },
        --   a string constant: "this is a string"
        String = {
            fg = c.tertiary
        },
        -- any variable name
        Identifier = {
            fg = c.magenta,
            style = config.variable_style
        },
        -- (preferred) any statement
        Statement = {
            fg = c.magenta
        },
        -- "sizeof", "+", "*", etc.
        Operator = {
            fg = c.secondary
        },
        --  any other keyword
        Keyword = {
            fg = c.cyan,
            style = config.keyword_style
        },
        -- (preferred) generic Preprocessor
        PreProc = {
            fg = c.cyan
        },
        -- (preferred) int, long, char, etc.
        Type = {
            fg = c.tertiary
        },
        -- (preferred) any special symbol
        Special = {
            fg = c.secondary
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
            TSNumber = {
                fg = c.cyan
            },
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
                bg = c.bg_highlight,
                fg = c.fg
            },
            NeogitHunkHeaderHighlight = {
                bg = c.faded,
                fg = c.blue
            },
            NeogitDiffContextHighlight = {
                bg = c.faded,
                fg = c.none
            },
            NeogitDiffDeleteHighlight = {
                fg = c.git.delete,
                bg = c.diff.delete
            },
            NeogitDiffAddHighlight = {
                fg = c.git.add,
                bg = c.diff.add
            },
        }
        return t
    end
    local function nvimtree(config, c)
        local t = {}
        t = {
            -- NvimTree
            NvimTreeNormal = {
                fg = c.fg_sidebar,
                bg = c.bg_sidebar
            },
            NvimTreeNormalNC = {
                fg = c.fg_sidebar,
                bg = c.bg_sidebar
            },
            NvimTreeRootFolder = {
                fg = c.primary,
                style = "bold"
            },
            NvimTreeGitDirty = {
                fg = c.git.change
            },
            NvimTreeGitNew = {
                fg = c.git.add
            },
            NvimTreeGitDeleted = {
                fg = c.git.delete
            },
            NvimTreeSpecialFile = {
                fg = c.magenta2,
                style = "underline"
            },
            NvimTreeIndentMarker = {
                fg = c.faded
            },
            NvimTreeImageFile = {
                fg = c.fg_sidebar
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
                fg = c.git.add
            },
            diffRemoved = {
                fg = c.git.delete
            },
            diffChanged = {
                fg = c.git.change
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
                fg = c.comment
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
                fg = c.gitSigns.add
            },
            -- diff mode: Changed line |diff.txt|
            GitSignsChange = {
                fg = c.gitSigns.change
            },
            -- diff mode: Deleted line |diff.txt|
            GitSignsDelete = {
                fg = c.gitSigns.delete
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
        comment = c.cyan2,
        border  = c.black, -- split, vertsplit
        error   = c.red2,
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

    G = theme
    return theme, defer, colors
end

return M
