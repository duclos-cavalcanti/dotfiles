"        Name: Custom
"     Creator: Daniel Duclos-Cavalcanti 
"     License: GNU General Public License v2.0 (see: LICENSE)
"  Repository: dotfiles

" Description:

hi clear

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

hi Boolean              gui=NONE        guifg=#ae81ff     guibg=NONE        cterm=NONE
hi Character            gui=NONE        guifg=#e6db74     guibg=NONE        cterm=NONE
hi Number               gui=NONE        guifg=#ae81ff     guibg=NONE        cterm=NONE
hi String               gui=NONE        guifg=#e6db74     guibg=NONE        cterm=NONE
hi Conditional          gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi Constant             gui=NONE        guifg=#ae81ff     guibg=NONE        cterm=NONE
hi Normal               gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi Comment              gui=NONE        guifg=#75715e     guibg=NONE        cterm=NONE
hi Todo                 gui=NONE        guifg=#ffffff     guibg=#66d9ef     cterm=NONE
hi Float                gui=NONE        guifg=#ae81ff     guibg=NONE        cterm=NONE
hi Identifier           gui=NONE        guifg=#fd971f     guibg=NONE        cterm=NONE
hi Function             gui=NONE        guifg=#a6e22e     guibg=NONE        cterm=NONE
hi PreCondit            gui=NONE        guifg=#a6e22e     guibg=NONE        cterm=NONE
hi PreProc              gui=NONE        guifg=#a6e22e     guibg=NONE        cterm=NONE
hi Macro                gui=NONE        guifg=#c4be89     guibg=NONE        cterm=NONE
hi Type                 gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi Typedef              gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi Structure            gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi Tag                  gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi StorageClass         gui=NONE        guifg=#fd971f     guibg=NONE        cterm=NONE
hi Statement            gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi Repeat               gui=NONE        guifg=#88c0d0     guibg=NONE        cterm=NONE
hi Label                gui=NONE        guifg=#e6db74     guibg=NONE        cterm=NONE
hi Operator             gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi Exception            gui=NONE        guifg=#a6e22e     guibg=NONE        cterm=NONE
hi Keyword              gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi Ignore               gui=NONE        guifg=#808080     guibg=NONE        cterm=NONE
hi Special              gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi SpecialChar          gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi SpecialComment       gui=NONE        guifg=#7e8e91     guibg=NONE        cterm=NONE
hi SpecialKey           gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi Pmenu                gui=NONE        guifg=#66d9ef     guibg=#000000     cterm=NONE
hi PmenuSel             gui=NONE        guifg=NONE        guibg=#808080     cterm=NONE
hi PmenuSbar            gui=NONE        guifg=NONE        guibg=#080808     cterm=NONE
hi PmenuThumb           gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi WildMenu             gui=NONE        guifg=#ffffff     guibg=#66d9ef     cterm=NONE
hi MatchParen           gui=NONE        guifg=#fd971f     guibg=NONE        cterm=NONE
hi SpellBad             gui=NONE        guifg=#f92672     guibg=NONE        cterm=underline
hi SpellCap             gui=NONE        guifg=#7070f0     guibg=NONE        cterm=underline
hi SpellLocal           gui=NONE        guifg=#7070f0     guibg=NONE        cterm=underline
hi SpellRare            gui=NONE        guifg=#ffffff     guibg=NONE        cterm=underline
hi Cursor               gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi iCursor              gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi Debug                gui=NONE        guifg=#bca3a3     guibg=NONE        cterm=NONE
hi Define               gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi Delimiter            gui=NONE        guifg=#8F8F8F     guibg=NONE        cterm=NONE
hi CursorLine           gui=NONE        guifg=NONE        guibg=NONE        cterm=NONE
hi CursorColumn         gui=NONE        guifg=white       guibg=NONE        cterm=NONE
hi SignColumn           gui=NONE        guifg=white       guibg=#232526     cterm=NONE
hi ColorColumn          gui=NONE        guifg=NONE        guibg=#232526     cterm=NONE
hi Folded               gui=NONE        guifg=#465457     guibg=NONE        cterm=NONE   
hi FoldColumn           gui=NONE        guifg=#465457     guibg=NONE        cterm=NONE    
hi VertSplit            gui=NONE        guifg=#808080     guibg=#080808     cterm=NONE
hi LineNr               gui=NONE        guifg=#bcbcbc     guibg=#232526     cterm=NONE
hi CursorLineNr         gui=NONE        guifg=#fd971f     guibg=#232526     cterm=NONE
hi NonText              gui=NONE        guifg=NONE        guibg=NONE        cterm=NONE
hi QuickFixLine         gui=NONE        guifg=NONE        guibg=NONE        cterm=NONE
hi Visual               gui=NONE        guifg=#263238     guibg=#c4be89     cterm=NONE 
hi VisualNOS            gui=NONE        guifg=#263238     guibg=#c4be89     cterm=NONE 
hi Search               gui=NONE        guifg=#263238     guibg=#c4be89     cterm=NONE 
hi IncSearch            gui=NONE        guifg=#263238     guibg=#c4be89     cterm=NONE 
hi Error                gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi ErrorMsg             gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi ModeMsg              gui=NONE        guifg=#e6db74     guibg=NONE        cterm=NONE
hi MoreMsg              gui=NONE        guifg=#e6db74     guibg=NONE        cterm=NONE
hi WarningMsg           gui=NONE        guifg=#82b414     guibg=NONE        cterm=NONE
hi MsgArea              gui=NONE        guifg=#ffffff     guibg=NONE        cterm=NONE
hi Question             gui=NONE        guifg=#66d9ef     guibg=NONE        cterm=NONE
hi Repeat               gui=NONE        guifg=#f92672     guibg=NONE        cterm=NONE
hi DiffAdd              gui=NONE        guifg=#82b414     guibg=#13354a     cterm=NONE
hi DiffText             gui=NONE        guifg=#88c0d0     guibg=#13354a     cterm=NONE
hi DiffChange           gui=NONE        guifg=#89807d     guibg=#13354a     cterm=NONE
hi DiffDelete           gui=NONE        guifg=#960050     guibg=#13354a     cterm=NONE
hi Directory            gui=NONE        guifg=#a6e22e     guibg=NONE        cterm=bold
hi Title                gui=NONE        guifg=#ef5939     guibg=NONE        cterm=NONE
hi ToolbarButton        gui=NONE        guifg=#88c0d0     guibg=#616E88     cterm=NONE
hi ToolbarLine          gui=NONE        guifg=#d8dee9     guibg=#616E88     cterm=NONE
hi StatusLine           gui=NONE        guifg=#ffffff     guibg=#232526     cterm=NONE
hi StatusLineNC         gui=NONE        guifg=NONE        guibg=#232526     cterm=NONE
hi EmptyStatusLine      gui=NONE        guifg=#d8dee9     guibg=#232526     cterm=NONE
hi ModeStatusLine       gui=NONE        guifg=#000000     guibg=#bcbcbc     cterm=NONE
hi ModeInsertStatusLine gui=NONE        guifg=#080808     guibg=#f92672     cterm=NONE
hi ModeVisualStatusLine gui=NONE        guifg=#080808     guibg=#a6e22e     cterm=NONE
hi GitStatusLine        gui=NONE        guifg=#ffffff     guibg=#232526     cterm=NONE
hi LineStatusLine       gui=NONE        guifg=#000000     guibg=#bcbcbc     cterm=NONE
hi LinterStatusLine     gui=NONE        guifg=#ffffff     guibg=#66d9ef     cterm=NONE
hi BufferStatusLine     gui=NONE        guifg=#ffffff     guibg=#808080     cterm=NONE
hi FileTypeStatusLine   gui=NONE        guifg=#ffffff     guibg=#232526     cterm=NONE
hi FileStatusLine       gui=NONE        guifg=#ffffff     guibg=#808080     cterm=NONE
hi TabLineSel           gui=NONE        guifg=#ffffff     guibg=#232526     cterm=NONE
hi TabLineMod           gui=NONE        guifg=#808080     guibg=#f92672     cterm=NONE
hi TabLineFill          gui=NONE        guifg=#1b1d1e     guibg=#232526     cterm=NONE
hi TabLine              gui=NONE        guifg=#8f8f8f     guibg=#232526     cterm=NONE
hi TabSelectedSpace     gui=NONE        guifg=#2e3440     guibg=#88c0d0     cterm=NONE
hi TabSpace             gui=NONE        guifg=#616E88     guibg=#232526     cterm=NONE

hi Terminal             gui=NONE      guifg=NONE        guibg=#1b1d1e
let g:terminal_ansi_colors = [
  \ '#ffffff', 
  \ '#f92672', 
  \ '#82b414', 
  \ '#fd971f',
  \ '#66d9ef', 
  \ '#8c54fe', 
  \ '#56c2d6', 
  \ '#ffffff',
  \ '#75715e', 
  \ '#f92672', 
  \ '#82b414', 
  \ '#fd971f',
  \ '#66d9ef', 
  \ '#8c54fe', 
  \ '#56c2d6', 
  \ '#ffffff'
\]

hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
