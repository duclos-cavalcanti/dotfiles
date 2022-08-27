local M = {}

function M.setup()
    local config = require("custom-scheme.config")
    local colors = require("custom-scheme.colors").setup(config)

    local theme = {
        config = config,
        colors = colors,
    }

    local c = theme.colors

    theme.base = {
        Comment = { fg = c.comment, style = config.comment_style }, -- any comment
        ColorColumn = { bg = config.columnline and c.bg_statusline or c.none }, -- used for the columns set with 'colorcolumn'
        Conceal = { fg = c.secondary }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor = { fg = c.bg, bg = c.fg }, -- character under the cursor
        lCursor = { fg = c.bg, bg = c.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorColumn = { bg = config.columnline and c.bg_statusline or c.none }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine = { bg = config.cursorline and c.bg_statusline or c.none }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory = { fg = c.primary }, -- directory names (and other special names in listings)
        DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
        DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
        DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
        DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer = { fg = c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        ErrorMsg = { fg = c.error }, -- error messages on the command line
        VertSplit = { fg = c.border }, -- the column separating vertically split windows
        Folded = { fg = c.primary, bg = c.faded }, -- line used for closed folds
        FoldColumn = { bg = c.bg, fg = c.comment }, -- 'foldcolumn'
        SignColumn = { bg = config.transparent and c.none or c.bg, fg = c.faded }, -- column where |signs| are displayed
        SignColumnSB = { bg = c.bg_sidebar, fg = c.faded }, -- column where |signs| are displayed
        Substitute = { bg = c.secondary, fg = c.black }, -- |:substitute| replacement text highlighting
        LineNr = { fg = c.grey }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr = { fg = c.fg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen = { fg = c.yellow2, style = "bold" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = { fg = c.fg, style = "bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea = { fg = c.fg }, -- Area for messages and cmdline
        MoreMsg = { fg = c.primary }, -- |more-prompt|
        NonText = { fg = c.grey }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = { fg = c.fg, bg = config.transparent and c.none or c.bg }, -- normal text
        NormalNC = { fg = c.fg, bg = config.transparent and c.none or c.bg }, -- normal text in non-current windows
        NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in non-current windows
        NormalFloat = { fg = c.fg, bg = c.bg_float }, -- Normal text in floating windows.
        FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
        Pmenu = { bg = c.bg_popup, fg = c.fg }, -- Popup menu: normal item.
        PmenuSel = { bg = c.faded }, -- Popup menu: selected item.
        PmenuSbar = { bg = c.bg_popup }, -- Popup menu: scrollbar.
        PmenuThumb = { bg = c.faded }, -- Popup menu: Thumb of the scrollbar.
        Question = { fg = c.primary }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine = { bg = c.bg_visual, style = "bold" }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search = { bg = c.bg_search, fg = c.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch = { bg = c.yellow2, fg = c.black }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        SpecialKey = { fg = c.grey }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad = { sp = c.error, style = "undercurl" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = { sp = c.warning, style = "undercurl" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { sp = c.info, style = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = { sp = c.hint, style = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine = { fg = c.fg_statusline, bg = c.bg_statusline }, -- status line of current window
        StatusLineNC = { fg = c.faded, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine = { bg = c.tabline.bg, fg = c.tabline.fg }, -- tab pages line, not active tab page label
        TabLineFill = { bg = c.tabline.bg_fill }, -- tab pages line, where there are no labels
        TabLineSel = { fg = c.tabline.fg_sel, bg = c.tabline.bg_sel }, -- tab pages line, active tab page label
        Title = { fg = c.primary, style = "bold" }, -- titles for output from ":set all", ":autocmd" etc.
        Visual = { bg = c.bg_visual }, -- Visual mode selection
        VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = { fg = c.warning }, -- warning messages
        Whitespace = { fg = c.faded }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion

        Constant = { fg = c.yellow2 }, -- (preferred) any constant
        String = { fg = c.tertiary }, --   a string constant: "this is a string"
        Character = { fg = c.tertiary }, --  a character constant: 'c', '\n'

        Identifier = { fg = c.magenta, style = config.variable_style }, -- (preferred) any variable name
        Function = { fg = c.cyan, style = config.function_style }, -- function name (also: methods for classes)

        Statement = { fg = c.magenta }, -- (preferred) any statement
        Operator = { fg = c.secondary }, -- "sizeof", "+", "*", etc.
        Keyword = { fg = c.cyan, style = config.keyword_style }, --  any other keyword

        PreProc = { fg = c.cyan }, -- (preferred) generic Preprocessor

        Type = { fg = c.tertiary }, -- (preferred) int, long, char, etc.

        Special = { fg = c.secondary }, -- (preferred) any special symbol

        Underlined = { style = "underline" }, -- (preferred) text that stands out, HTML links
        Bold = { style = "bold" },
        Italic = { style = "italic" },

        Error = { fg = c.error }, -- (preferred) any erroneous construct
        Todo = { bg = c.yellow, fg = c.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        qfLineNr = { fg = c.grey },
        qfFileName = { fg = c.blue },

        htmlH1 = { fg = c.magenta, style = "bold" },
        htmlH2 = { fg = c.blue, style = "bold" },

        mkdCodeDelimiter = { bg = c.terminal_black, fg = c.fg },
        mkdCodeStart = { fg = c.grey, style = "bold" },
        mkdCodeEnd = { fg = c.grey, style = "bold" },

        markdownHeadingDelimiter = { fg = c.yellow2, style = "bold" },
        markdownCode = { fg = c.grey },
        markdownCodeBlock = { fg = c.grey },
        markdownH1 = { fg = c.primary, style = "bold" },
        markdownH2 = { fg = c.primary, style = "bold" },
        markdownLinkText = { fg = c.blue, style = "underline" },

        debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
        debugBreakpoint = { bg = c.info, fg = c.info }, -- used for breakpoint colors in terminal-debug

        LspReferenceText = { bg = c.faded }, -- used for highlighting "text" references
        LspReferenceRead = { bg = c.faded }, -- used for highlighting "read" references
        LspReferenceWrite = { bg = c.faded }, -- used for highlighting "write" references
        LspSignatureActiveParameter = { fg = c.yellow2 },
        LspCodeLens = { fg = c.comment },

        ALEErrorSign = { fg = c.error },
        ALEWarningSign = { fg = c.warning },

        DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

        DiagnosticVirtualTextError = { bg = c.none, fg = c.error }, -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn = { bg = c.none, fg = c.warning }, -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo = { bg = c.none, fg = c.info }, -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint = { bg = c.none, fg = c.hint }, -- Used for "Hint" diagnostic virtual text

        DiagnosticUnderlineError = { style = "undercurl", sp = c.error }, -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn = { style = "undercurl", sp = c.warning }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo = { style = "undercurl", sp = c.info }, -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint = { style = "undercurl", sp = c.hint }, -- Used to underline "Hint" diagnostics
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
            for snew, sold in pairs(severity_map) do
                theme.base["LspDiagnostics" .. type .. sold] = {
                    link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
                }
            end
        end
    end

    theme.plugins = {
        -- TSAnnotation        = { };    -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
        -- TSAttribute         = { };    -- (unstable) TODO: docs
        -- TSBoolean           = { };    -- For booleans.
        -- TSCharacter         = { };    -- For characters.
        -- TSComment           = { };    -- For comment blocks.
        TSNote = { fg = c.bg, bg = c.info },
        TSWarning = { fg = c.bg, bg = c.warning },
        TSDanger = { fg = c.bg, bg = c.error },
        TSConstructor = { fg = c.magenta }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
        -- TSConditional       = { };    -- For keywords related to conditionnals.
        -- TSConstant          = { };    -- For constants
        -- TSConstBuiltin      = { };    -- For constant that are built in the language: `nil` in Lua.
        -- TSConstMacro        = { };    -- For constants that are defined by macros: `NULL` in C.
        -- TSError             = { };    -- For syntax/parser errors.
        -- TSException         = { };    -- For exception related keywords.
        TSField = { fg = c.yellow }, -- For fields.
        -- TSFloat             = { };    -- For floats.
        TSFunction = { fg = c.primary },    -- For function (calls and definitions).
        -- TSFuncBuiltin       = { };    -- For builtin functions: `table.insert` in Lua.
        -- TSFuncMacro         = { };    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        -- TSInclude           = { };    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
        TSKeyword = { fg = c.magenta, style = config.keyword_style }, -- For keywords that don't fall in previous categories.
        TSKeywordFunction = { fg = c.magenta, style = config.functionStyle }, -- For keywords used to define a fuction.
        TSLabel = { fg = c.tertiary }, -- For labels: `label:` in C and `:label:` in Lua.
        -- TSMethod            = { };    -- For method calls and definitions.
        -- TSNamespace         = { };    -- For identifiers referring to modules and namespaces.
        -- TSNone              = { };    -- TODO: docs
        TSNumber = { fg = c.cyan },
        TSOperator = { fg = c.secondary }, -- For any operator: `+`, but also `->` and `*` in C.
        TSParameter = { fg = c.fg }, -- For parameters of a function.
        -- TSParameterReference= { };    -- For references to parameters of a function.
        TSProperty = { fg = c.magenta2 }, -- Same as `TSField`.
        TSPunctDelimiter = { fg = c.cyan2 }, -- For delimiters ie: `.`
        TSPunctBracket = { fg = c.cyan2 }, -- For brackets and parens.
        TSPunctSpecial = { fg = c.cyan2 }, -- For special punctutation that does not fall in the catagories before.
        -- TSRepeat            = { };    -- For keywords related to loops.
        -- TSString            = { };    -- For strings.
        TSStringRegex = { fg = c.primary }, -- For regexes.
        TSStringEscape = { fg = c.magenta }, -- For escape characters within a string.
        -- TSSymbol            = { };    -- For identifiers referring to symbols or atoms.
        -- TSType              = { };    -- For types.
        -- TSTypeBuiltin       = { };    -- For builtin types.
        TSVariable = { style = config.variableStyle }, -- Any variable name that does not have another highlight.
        TSVariableBuiltin = { fg = c.secondary }, -- Variable names that are defined by the languages, like `this` or `self`.

        -- TSTag               = { };    -- Tags like html tag names.
        -- TSTagDelimiter      = { };    -- Tag delimiter like `<` `>` `/`
        -- TSText              = { };    -- For strings considered text in a markup language.
        TSTextReference = { fg = c.grey },
        -- TSEmphasis          = { };    -- For text to be represented with emphasis.
        -- TSUnderline         = { };    -- For text to be represented with an underline.
        -- TSStrike            = { };    -- For strikethrough text.
        -- TSTitle             = { };    -- Text that is part of a title.
        -- TSLiteral           = { };    -- Literal text.
        -- TSURI               = { };    -- Any URI like a link or email.

        -- Lua
        luaTSProperty = { fg = c.secondary }, -- Same as `TSField`.

        -- LspTrouble
        LspTroubleText = { fg = c.error },
        LspTroubleCount = { fg = c.magenta, bg = c.faded },
        LspTroubleNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },

        -- diff
        diffAdded = { fg = c.git.add },
        diffRemoved = { fg = c.git.delete },
        diffChanged = { fg = c.git.change },
        diffOldFile = { fg = c.yellow },
        diffNewFile = { fg = c.yellow2 },
        diffFile = { fg = c.blue },
        diffLine = { fg = c.comment },
        diffIndexLine = { fg = c.magenta },

        -- Neogit
        NeogitBranch = { fg = c.magenta },
        NeogitRemote = { fg = c.magenta2 },
        NeogitHunkHeader = { bg = c.bg_highlight, fg = c.fg },
        NeogitHunkHeaderHighlight = { bg = c.faded, fg = c.blue },
        NeogitDiffContextHighlight = { bg = c.faded, fg = c.none },
        NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.diff.delete },
        NeogitDiffAddHighlight = { fg = c.git.add, bg = c.diff.add },

        -- GitGutter
        GitGutterAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
        GitGutterChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
        GitGutterDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|

        -- GitSigns
        GitSignsAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
        GitSignsChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
        GitSignsDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|

        -- Telescope
        TelescopeBorder = { fg = c.border_highlight, bg = c.bg_float },
        TelescopeNormal = { fg = c.fg, bg = c.bg_float },

        -- NvimTree
        NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        NvimTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        NvimTreeRootFolder = { fg = c.primary, style = "bold" },
        NvimTreeGitDirty = { fg = c.git.change },
        NvimTreeGitNew = { fg = c.git.add },
        NvimTreeGitDeleted = { fg = c.git.delete },
        NvimTreeSpecialFile = { fg = c.magenta2, style = "underline" },
        NvimTreeIndentMarker = { fg = c.faded },
        NvimTreeImageFile = { fg = c.fg_sidebar },
        NvimTreeSymlink = { fg = c.primary },
        -- NvimTreeFolderName= { fg = c.fg_float },

        -- LspSaga
        DiagnosticWarning = { link = "DiagnosticWarn" },
        DiagnosticInformation = { link = "DiagnosticInfo" },

        LspFloatWinNormal = { bg = c.bg_float },
        LspFloatWinBorder = { fg = c.border_highlight },
        LspSagaBorderTitle = { fg = c.cyan },
        LspSagaHoverBorder = { fg = c.primary },
        LspSagaRenameBorder = { fg = c.tertiary },
        LspSagaDefPreviewBorder = { fg = c.tertiary },
        LspSagaCodeActionBorder = { fg = c.primary },
        LspSagaFinderSelection = { fg = c.bg_visual },
        LspSagaCodeActionTitle = { fg = c.cyan2 },
        LspSagaCodeActionContent = { fg = c.magenta2 },
        LspSagaSignatureHelpBorder = { fg = c.secondary },
        ReferencesCount = { fg = c.magenta2 },
        DefinitionCount = { fg = c.magenta2 },
        DefinitionIcon = { fg = c.blue },
        ReferencesIcon = { fg = c.blue },
        TargetWord = { fg = c.cyan },

        -- NeoVim
        healthError = { fg = c.error },
        healthSuccess = { fg = c.green2 },
        healthWarning = { fg = c.warning },

        -- Cmp
        CmpDocumentation = { fg = c.fg, bg = c.bg_float },
        CmpDocumentationBorder = { fg = c.border_highlight, bg = c.bg_float },

        CmpItemAbbr = { fg = c.fg, bg = c.none },
        CmpItemAbbrDeprecated = { fg = c.faded, bg = c.none, style = "strikethrough" },
        CmpItemAbbrMatch = { fg = c.cyan2, bg = c.none },
        CmpItemAbbrMatchFuzzy = { fg = c.cyan2, bg = c.none },

        CmpItemKindDefault = { fg = c.grey, bg = c.none },
        CmpItemMenu = { fg = c.comment, bg = c.none },

        CmpItemKindKeyword = { fg = c.cyan, bg = c.none },

        CmpItemKindVariable = { fg = c.magenta, bg = c.none },
        CmpItemKindConstant = { fg = c.magenta, bg = c.none },
        CmpItemKindReference = { fg = c.magenta, bg = c.none },
        CmpItemKindValue = { fg = c.magenta, bg = c.none },

        CmpItemKindFunction = { fg = c.primary, bg = c.none },
        CmpItemKindMethod = { fg = c.primary, bg = c.none },
        CmpItemKindConstructor = { fg = c.primary, bg = c.none },

        CmpItemKindClass = { fg = c.yellow2, bg = c.none },
        CmpItemKindInterface = { fg = c.yellow2, bg = c.none },
        CmpItemKindStruct = { fg = c.yellow2, bg = c.none },
        CmpItemKindEvent = { fg = c.yellow2, bg = c.none },
        CmpItemKindEnum = { fg = c.yellow2, bg = c.none },
        CmpItemKindUnit = { fg = c.yellow2, bg = c.none },

        CmpItemKindModule = { fg = c.yellow, bg = c.none },

        CmpItemKindProperty = { fg = c.tertiary, bg = c.none },
        CmpItemKindField = { fg = c.tertiary, bg = c.none },
        CmpItemKindTypeParameter = { fg = c.tertiary, bg = c.none },
        CmpItemKindEnumMember = { fg = c.tertiary, bg = c.none },
        CmpItemKindOperator = { fg = c.tertiary, bg = c.none },
        CmpItemKindSnippet = { fg = c.cyan2, bg = c.none },
    }

    -- Lualine
    theme.lualine = {
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

    theme.defer = {}

    if config.hide_inactive_statusline then
        local inactive = { style = "underline", bg = c.bg, fg = c.bg, sp = c.border }

        -- StatusLineNC
        theme.base.StatusLineNC = inactive

        -- LuaLine
        for _, section in ipairs({ "a", "b", "c" }) do
            theme.defer["lualine_" .. section .. "_inactive"] = inactive
        end
    end

    return theme
end

return M
