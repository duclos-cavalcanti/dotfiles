"        Name: Custom
"     Creator: Daniel Duclos-Cavalcanti 
"     License: GNU General Public License v2.0 (see: LICENSE)
"  Repository: dotfiles

" Description:

if version > 580
    hi clear
    if exists('syntax_on')
        syntax reset
    endif
endif

if (has("termguicolors")) "Needed for larger color palette
    set termguicolors
endif

let g:colors_name = 'Custom'

hi Normal               gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi Comment              gui=NONE        guifg=#616E88     guibg=NONE        cterm=NONE
hi Todo                 gui=NONE        guifg=#ffffff     guibg=#5e81ac     cterm=NONE
hi Constant             gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi String               gui=NONE        guifg=#a3be8c     guibg=NONE        cterm=bold
hi Character            gui=NONE        guifg=#b48ead     guibg=NONE        cterm=bold
hi Number               gui=NONE        guifg=#bf616a     guibg=NONE        cterm=bold
hi Boolean              gui=NONE        guifg=#a3be8c     guibg=NONE        cterm=bold
hi Float                gui=NONE        guifg=#a3be8c     guibg=NONE        cterm=bold
hi Identifier           gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi Function             gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi PreProc              gui=NONE        guifg=#5e81ac     guibg=NONE        cterm=bold
hi Type                 gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi Typedef              gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi Structure            gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi StorageClass         gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi Statement            gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi Conditional          gui=NONE        guifg=#5e81ac     guibg=NONE        cterm=bold
hi Repeat               gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi Label                gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=bold
hi Operator             gui=NONE        guifg=#b48ead     guibg=NONE        cterm=bold
hi Exception            gui=NONE        guifg=#b48ead     guibg=NONE        cterm=bold
hi Keyword              gui=NONE        guifg=#5e81ac     guibg=NONE        cterm=bold
hi Ignore               gui=NONE        guifg=#b48ead     guibg=NONE        cterm=bold
hi Special              gui=NONE        guifg=#b48ead     guibg=NONE        cterm=NONE
hi SpecialKey           gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=NONE
hi Pmenu                gui=NONE        guifg=#2e3440     guibg=#ffffff     cterm=NONE
hi PmenuSel             gui=NONE        guifg=#2e3440     guibg=#88c0d0     cterm=NONE
hi PmenuSbar            gui=NONE        guifg=NONE        guibg=#ffffff     cterm=NONE
hi PmenuThumb           gui=NONE        guifg=#ffffff     guibg=#ffffff     cterm=NONE
hi WildMenu             gui=NONE        guifg=#2e3440     guibg=#88c0d0     cterm=NONE
hi MatchParen           gui=NONE        guifg=#bf616a     guibg=NONE        cterm=NONE
hi SpellBad             gui=NONE        guifg=#bf616a     guibg=NONE        cterm=underline
hi SpellCap             gui=NONE        guifg=#b48ead     guibg=NONE        cterm=underline
hi SpellLocal           gui=NONE        guifg=#b48ead     guibg=NONE        cterm=underline
hi Cursor               gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi CursorLine           gui=NONE        guifg=NONE        guibg=NONE        cterm=NONE
hi CursorColumn         gui=NONE        guifg=white       guibg=NONE        cterm=NONE
hi SignColumn           gui=NONE        guifg=white       guibg=NONE        cterm=NONE
hi ColorColumn          gui=NONE        guifg=NONE        guibg=#3b4252     cterm=NONE
hi Folded               gui=NONE        guifg=#616E88     guibg=NONE        cterm=NONE   
hi FoldColumn           gui=NONE        guifg=#616E88     guibg=NONE        cterm=NONE    
hi VertSplit            gui=NONE        guifg=#616E88     guibg=NONE        cterm=NONE
hi LineNr               gui=NONE        guifg=#4c556a     guibg=NONE        cterm=NONE
hi CursorLineNr         gui=NONE        guifg=#d8dee9     guibg=NONE        cterm=NONE
hi NonText              gui=NONE        guifg=NONE        guibg=NONE        cterm=NONE
hi QuickFixLine         gui=NONE        guifg=NONE        guibg=NONE        cterm=NONE
hi Visual               gui=NONE        guifg=#263238     guibg=#ffffff     cterm=NONE 
hi Search               gui=NONE        guifg=#263238     guibg=#ffffff     cterm=NONE 
hi IncSearch            gui=NONE        guifg=#263238     guibg=#ffffff     cterm=NONE 
hi ErrorMsg             gui=NONE        guifg=#bf616a     guibg=NONE        cterm=NONE
hi ModeMsg              gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi WarningMsg           gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=NONE
hi MsgArea              gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi MoreMsg              gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi Question             gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi DiffAdd              gui=NONE        guifg=#a3be8c     guibg=#3b4252     cterm=NONE
hi DiffText             gui=NONE        guifg=#88c0d0     guibg=#3b4252     cterm=NONE
hi DiffChange           gui=NONE        guifg=#ebcb8b     guibg=#3b4252     cterm=NONE
hi DiffDelete           gui=NONE        guifg=#bf616a     guibg=#3b4252     cterm=NONE
hi Directory            gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=BOLD
hi Title                gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=NONE
hi ToolbarButton        gui=NONE        guifg=#88c0d0     guibg=#616E88     cterm=NONE
hi ToolbarLine          gui=NONE        guifg=#d8dee9     guibg=#616E88     cterm=NONE
hi StatusLine           gui=NONE        guifg=#616E88     guibg=#3b4252     cterm=NONE
hi StatusLineNC         gui=NONE        guifg=NONE        guibg=#3b4252     cterm=NONE
hi EmptyStatusLine      gui=NONE        guifg=#d8dee9     guibg=#3b4252     cterm=NONE
hi ModeStatusLine       gui=NONE        guifg=#2e3440     guibg=#88c0d0     cterm=NONE
hi ModeInsertStatusLine gui=NONE        guifg=#2e3440     guibg=#d8dee9     cterm=NONE
hi ModeVisualStatusLine gui=NONE        guifg=#2e3440     guibg=#8fbcbb     cterm=NONE
hi GitStatusLine        gui=NONE        guifg=#d8dee9     guibg=#3b4252     cterm=NONE
hi LineStatusLine       gui=NONE        guifg=#2e3440     guibg=#88c0d0     cterm=NONE
hi LinterStatusLine     gui=NONE        guifg=#ffffff     guibg=#88c0d0     cterm=NONE
hi BufferStatusLine     gui=NONE        guifg=#ffffff     guibg=#3b4252     cterm=BOLD
hi FileTypeStatusLine   gui=NONE        guifg=#d8dee9     guibg=#3b4252     cterm=NONE
hi FileStatusLine       gui=NONE        guifg=#d8dee9     guibg=#3b4252     cterm=NONE
hi TabLineSel           gui=NONE        guifg=#2e3440     guibg=#88c0d0     cterm=NONE
hi TabLineMod           gui=NONE        guifg=#2e3440     guibg=#bf616a     cterm=NONE
hi TabLineFill          gui=NONE        guifg=#d8dee9     guibg=NONE        cterm=NONE
hi TabLine              gui=NONE        guifg=#d8dee9     guibg=#4a5469     cterm=NONE
hi TabSelectedSpace     gui=NONE        guifg=#2e3440     guibg=#88c0d0     cterm=NONE
hi TabSpace             gui=NONE        guifg=#616E88     guibg=#3b4252     cterm=NONE

hi Terminal             gui=NONE      guifg=NONE        guibg=#2e3440
let g:terminal_ansi_colors = [
  \ '#ffffff', 
  \ '#bf616a', 
  \ '#a3be8c', 
  \ '#ebcb8b',
  \ '#88c0d0', 
  \ '#b48ead', 
  \ '#5e81ac', 
  \ '#ffffff',
  \ '#7c818c', 
  \ '#bf616a', 
  \ '#a3be8c', 
  \ '#ebcb8b',
  \ '#88c0d0', 
  \ '#b48ead', 
  \ '#5e81ac', 
  \ '#ffffff'
\]

hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
