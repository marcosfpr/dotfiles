" Name:         pablito
"
set background=dark

hi clear
let g:colors_name = 'pablito_soft'

let s:t_Co = has('gui_running') ? 16777216 : str2nr(&t_Co)
let s:tgc = has('termguicolors') && &termguicolors

" Slightly softened bright green & cyan
let g:terminal_ansi_colors = [
      \ '#000000',
      \ '#cd0000',
      \ '#00cd00',
      \ '#cdcd00',
      \ '#0000ee',
      \ '#cd00cd',
      \ '#00bcbc',
      \ '#e5e5e5',
      \ '#7f7f7f',
      \ '#ff0000',
      \ '#00dd00',
      \ '#ffff00',
      \ '#5c5cff',
      \ '#ff00ff',
      \ '#00d0d0',
      \ '#ffffff'
      \ ]

hi! link CurSearch Search
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi! link Float Number
hi! link Function Identifier
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link MessageWindow Pmenu
hi! link Number Constant
hi! link PopupNotification Todo
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabPanel Normal
hi! link TabPanelFill EndOfBuffer
hi! link Terminal Normal

hi Normal         guifg=#ffffff guibg=#000000 guisp=NONE gui=NONE ctermfg=231 ctermbg=16  cterm=NONE term=NONE
hi ColorColumn    guifg=NONE    guibg=#4d4d4d guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE term=reverse
hi Comment        guifg=#808080 guibg=NONE    guisp=NONE gui=NONE ctermfg=244 ctermbg=NONE cterm=NONE term=bold
hi Conceal        guifg=#666666 guibg=NONE    guisp=NONE gui=NONE ctermfg=241 ctermbg=NONE cterm=NONE term=NONE

" toned-down bright cyan
hi Constant       guifg=#00d0d0 guibg=NONE    guisp=NONE gui=NONE ctermfg=51  ctermbg=NONE cterm=NONE term=NONE

hi Cursor         guifg=#000000 guibg=#ffffff guisp=NONE gui=NONE ctermfg=16  ctermbg=231 cterm=NONE term=reverse
hi CursorColumn   guifg=NONE    guibg=#3a3a3a guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE term=NONE
hi CursorIM       guifg=NONE    guibg=fg      guisp=NONE gui=NONE ctermfg=NONE ctermbg=fg  cterm=NONE term=NONE
hi CursorLine     guifg=NONE    guibg=#3a3a3a guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE term=underline
hi CursorLineNr   guifg=#ffff00 guibg=#3a3a3a guisp=NONE gui=bold ctermfg=226 ctermbg=237 cterm=bold term=bold
hi DiffAdd        guifg=#ffffff guibg=#5f875f guisp=NONE gui=NONE ctermfg=231 ctermbg=65  cterm=NONE term=reverse
hi DiffChange     guifg=#ffffff guibg=#5f87af guisp=NONE gui=NONE ctermfg=231 ctermbg=67  cterm=NONE term=NONE
hi DiffDelete     guifg=#ffffff guibg=#af5faf guisp=NONE gui=NONE ctermfg=231 ctermbg=133 cterm=NONE term=reverse
hi DiffText       guifg=#000000 guibg=#c6c6c6 guisp=NONE gui=NONE ctermfg=16  ctermbg=251 cterm=NONE term=reverse
hi Directory      guifg=#00c000 guibg=NONE    guisp=NONE gui=NONE ctermfg=34  ctermbg=NONE cterm=NONE term=NONE
hi EndOfBuffer    guifg=#0000ff guibg=NONE    guisp=NONE gui=bold ctermfg=63  ctermbg=NONE cterm=bold term=NONE
hi Error          guifg=#ffffff guibg=#ff0000 guisp=NONE gui=NONE ctermfg=231 ctermbg=196 cterm=NONE term=bold,reverse
hi ErrorMsg       guifg=#ffffff guibg=#cd0000 guisp=NONE gui=NONE ctermfg=231 ctermbg=160 cterm=NONE term=bold,reverse
hi FoldColumn     guifg=#7f7f7f guibg=#303030 guisp=NONE gui=NONE ctermfg=102 ctermbg=236 cterm=NONE term=NONE
hi Folded         guifg=#7f7f7f guibg=#303030 guisp=NONE gui=NONE ctermfg=102 ctermbg=236 cterm=NONE term=NONE

" cyan-ish identifier kept, a bit darker than FullBright cyan already
hi Identifier     guifg=#00c0c0 guibg=NONE    guisp=NONE gui=NONE ctermfg=37  ctermbg=NONE cterm=NONE term=NONE

hi Ignore         guifg=#000000 guibg=#000000 guisp=NONE gui=NONE ctermfg=16  ctermbg=16  cterm=NONE term=NONE
hi IncSearch      guifg=#ffffff guibg=NONE    guisp=NONE gui=reverse ctermfg=231 ctermbg=NONE cterm=reverse term=bold,reverse,underline
hi LineNr         guifg=#7f7f7f guibg=NONE    guisp=NONE gui=NONE ctermfg=102 ctermbg=NONE cterm=NONE term=NONE
hi MatchParen     guifg=NONE    guibg=#008b8b guisp=NONE gui=NONE ctermfg=NONE ctermbg=44  cterm=NONE term=bold,underline
hi ModeMsg        guifg=NONE    guibg=NONE    guisp=NONE gui=bold  ctermfg=NONE ctermbg=NONE cterm=bold term=bold
hi MoreMsg        guifg=#5c5cff guibg=NONE    guisp=NONE gui=bold  ctermfg=63  ctermbg=NONE cterm=bold term=NONE
hi NonText        guifg=#0000ff guibg=NONE    guisp=NONE gui=bold  ctermfg=63  ctermbg=NONE cterm=bold term=NONE
hi Pmenu          guifg=fg      guibg=#303030 guisp=NONE gui=NONE ctermfg=fg  ctermbg=236 cterm=NONE term=reverse
hi PmenuMatch     guifg=#ff00ff guibg=#303030 guisp=NONE gui=NONE ctermfg=201 ctermbg=236 cterm=NONE term=NONE
hi PmenuMatchSel  guifg=#ff00ff guibg=#e5e5e5 guisp=NONE gui=NONE ctermfg=201 ctermbg=254 cterm=NONE term=NONE
hi PmenuSbar      guifg=NONE    guibg=NONE    guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=reverse
hi PmenuSel       guifg=#000000 guibg=#e5e5e5 guisp=NONE gui=NONE ctermfg=16  ctermbg=254 cterm=NONE term=bold
hi PmenuThumb     guifg=NONE    guibg=#ffffff guisp=NONE gui=NONE ctermfg=NONE ctermbg=231 cterm=NONE term=NONE

" toned-down bright green
hi PreProc        guifg=#00dd00 guibg=NONE    guisp=NONE gui=NONE ctermfg=46  ctermbg=NONE cterm=NONE term=NONE

" toned-down bright green
hi Question       guifg=#00dd00 guibg=NONE    guisp=NONE gui=bold  ctermfg=121 ctermbg=NONE cterm=bold term=standout

" slightly softer cyan background
hi QuickFixLine   guifg=#000000 guibg=#00bcbc guisp=NONE gui=NONE ctermfg=16  ctermbg=44  cterm=NONE term=NONE

hi Search         guifg=#000000 guibg=#c0c000 guisp=NONE gui=NONE ctermfg=16  ctermbg=142 cterm=NONE term=reverse

" toned-down bright cyan
hi SignColumn     guifg=#00d0d0 guibg=#a9a9a9 guisp=NONE gui=NONE ctermfg=51  ctermbg=248 cterm=NONE term=reverse

hi Special        guifg=#0000ff guibg=NONE    guisp=NONE gui=NONE ctermfg=21  ctermbg=NONE cterm=NONE term=NONE

" toned-down bright cyan
hi SpecialKey     guifg=#00d0d0 guibg=NONE    guisp=NONE gui=NONE ctermfg=81  ctermbg=NONE cterm=NONE term=bold

hi SpellBad       guifg=#ff0000 guibg=NONE    guisp=#ff0000 gui=undercurl ctermfg=196 ctermbg=NONE cterm=underline term=underline
hi SpellCap       guifg=#5c5cff guibg=NONE    guisp=#5c5cff gui=undercurl ctermfg=63  ctermbg=NONE cterm=underline term=underline
hi SpellLocal     guifg=#ff00ff guibg=NONE    guisp=#ff00ff gui=undercurl ctermfg=201 ctermbg=NONE cterm=underline term=underline
hi SpellRare      guifg=#ffff00 guibg=NONE    guisp=#ffff00 gui=undercurl ctermfg=226 ctermbg=NONE cterm=underline term=underline
hi Statement      guifg=#c0c000 guibg=NONE    guisp=NONE gui=bold ctermfg=142 ctermbg=NONE cterm=bold term=NONE
hi StatusLine     guifg=#ffff00 guibg=#0000ee guisp=NONE gui=NONE ctermfg=226 ctermbg=20  cterm=NONE term=bold,reverse
hi StatusLineNC   guifg=#000000 guibg=#ffffff guisp=NONE gui=NONE ctermfg=16  ctermbg=231 cterm=NONE term=bold,underline
hi TabLine        guifg=#ffffff guibg=#7f7f7f guisp=NONE gui=NONE ctermfg=231 ctermbg=102 cterm=NONE term=bold,underline
hi TabLineFill    guifg=NONE    guibg=#000000 guisp=NONE gui=reverse ctermfg=NONE ctermbg=16  cterm=reverse term=NONE
hi TabLineSel     guifg=#ffffff guibg=#000000 guisp=NONE gui=bold ctermfg=231 ctermbg=16  cterm=bold term=bold,reverse
hi Title          guifg=#ff00ff guibg=NONE    guisp=NONE gui=bold ctermfg=225 ctermbg=NONE cterm=bold term=NONE
hi TitleBar       guifg=#ffffff guibg=#3c3c3c guisp=NONE gui=NONE ctermfg=231 ctermbg=237 cterm=NONE term=NONE
hi TitleBarNC     guifg=#e5e5e5 guibg=#2c2c2c guisp=NONE gui=NONE ctermfg=254 ctermbg=236 cterm=NONE term=NONE
hi Todo           guifg=#000000 guibg=#c0c000 guisp=NONE gui=NONE ctermfg=16  ctermbg=142 cterm=NONE term=bold,reverse
hi ToolbarButton  guifg=#000000 guibg=#e5e5e5 guisp=NONE gui=bold ctermfg=16  ctermbg=254 cterm=bold term=bold,reverse
hi ToolbarLine    guifg=NONE    guibg=#000000 guisp=NONE gui=NONE ctermfg=NONE ctermbg=16  cterm=NONE term=reverse
hi Type           guifg=#00c000 guibg=NONE    guisp=NONE gui=NONE ctermfg=34  ctermbg=NONE cterm=NONE term=NONE
hi Underlined     guifg=#80a0ff guibg=NONE    guisp=NONE gui=underline ctermfg=111 ctermbg=NONE cterm=underline term=underline
hi VertSplit      guifg=#000000 guibg=#ffffff guisp=NONE gui=NONE ctermfg=16  ctermbg=231 cterm=NONE term=NONE
hi Visual         guifg=#00008b guibg=#a9a9a9 guisp=NONE gui=NONE ctermfg=20  ctermbg=248 cterm=NONE term=reverse
hi VisualNOS      guifg=NONE    guibg=#000000 guisp=NONE gui=bold,underline ctermfg=NONE ctermbg=16  cterm=underline term=NONE
hi WarningMsg     guifg=#ff0000 guibg=NONE    guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE term=standout
hi WildMenu       guifg=#000000 guibg=#ffff00 guisp=NONE gui=NONE ctermfg=16  ctermbg=226 cterm=NONE term=bold
hi lCursor        guifg=#000000 guibg=#ffffff guisp=NONE gui=NONE ctermfg=16  ctermbg=231 cterm=NONE term=NONE

if s:tgc || s:t_Co >= 256
  finish
endif

if s:t_Co >= 16
  hi Normal        ctermfg=white   ctermbg=black     cterm=NONE
  hi ColorColumn   ctermfg=white   ctermbg=darkgrey  cterm=NONE
  hi Comment       ctermfg=darkgrey ctermbg=NONE     cterm=NONE
  hi Conceal       ctermfg=darkgrey ctermbg=NONE     cterm=NONE

  " use darker cyan in 16-color too
  hi Constant      ctermfg=darkcyan ctermbg=NONE     cterm=NONE

  hi Cursor        ctermfg=black   ctermbg=white     cterm=NONE
  hi CursorColumn  ctermfg=NONE    ctermbg=NONE      cterm=underline
  hi CursorIM      ctermfg=NONE    ctermbg=fg        cterm=NONE
  hi CursorLine    ctermfg=NONE    ctermbg=NONE      cterm=underline
  hi CursorLineNr  ctermfg=yellow  ctermbg=NONE      cterm=underline
  hi DiffAdd       ctermfg=white   ctermbg=darkgreen cterm=NONE
  hi DiffChange    ctermfg=white   ctermbg=blue      cterm=NONE
  hi DiffDelete    ctermfg=white   ctermbg=magenta   cterm=NONE
  hi DiffText      ctermfg=black   ctermbg=grey      cterm=NONE
  hi Directory     ctermfg=darkgreen ctermbg=NONE    cterm=NONE
  hi EndOfBuffer   ctermfg=blue    ctermbg=NONE      cterm=bold
  hi Error         ctermfg=white   ctermbg=red       cterm=NONE
  hi ErrorMsg      ctermfg=white   ctermbg=darkred   cterm=NONE
  hi FoldColumn    ctermfg=NONE    ctermbg=NONE      cterm=NONE
  hi Folded        ctermfg=blue    ctermbg=NONE      cterm=NONE

  hi Identifier    ctermfg=darkcyan ctermbg=NONE     cterm=NONE

  hi Ignore        ctermfg=black   ctermbg=black     cterm=NONE
  hi IncSearch     ctermfg=white   ctermbg=NONE      cterm=reverse
  hi LineNr        ctermfg=darkgrey ctermbg=NONE     cterm=NONE
  hi MatchParen    ctermfg=NONE    ctermbg=darkcyan  cterm=NONE
  hi ModeMsg       ctermfg=NONE    ctermbg=NONE      cterm=bold
  hi MoreMsg       ctermfg=blue    ctermbg=NONE      cterm=bold
  hi NonText       ctermfg=blue    ctermbg=NONE      cterm=bold
  hi Pmenu         ctermfg=fg      ctermbg=darkgrey  cterm=NONE
  hi PmenuMatch    ctermfg=fg      ctermbg=darkgrey  cterm=bold
  hi PmenuMatchSel ctermfg=black   ctermbg=grey      cterm=bold
  hi PmenuSbar     ctermfg=NONE    ctermbg=NONE      cterm=NONE
  hi PmenuSel      ctermfg=black   ctermbg=grey      cterm=NONE
  hi PmenuThumb    ctermfg=NONE    ctermbg=white     cterm=NONE

  " darker green
  hi PreProc       ctermfg=darkgreen ctermbg=NONE    cterm=NONE

  " darker green
  hi Question      ctermfg=darkgreen ctermbg=NONE    cterm=bold

  hi QuickFixLine  ctermfg=black   ctermbg=darkcyan  cterm=NONE
  hi Search        ctermfg=black   ctermbg=darkyellow cterm=NONE

  " darker cyan
  hi SignColumn    ctermfg=darkcyan ctermbg=black    cterm=NONE

  hi Special       ctermfg=blue    ctermbg=NONE      cterm=NONE

  " darker cyan
  hi SpecialKey    ctermfg=darkcyan ctermbg=NONE     cterm=NONE

  hi SpellBad      ctermfg=red     ctermbg=NONE      cterm=underline
  hi SpellCap      ctermfg=blue    ctermbg=NONE      cterm=underline
  hi SpellLocal    ctermfg=magenta ctermbg=NONE      cterm=underline
  hi SpellRare     ctermfg=yellow  ctermbg=NONE      cterm=underline
  hi Statement     ctermfg=darkyellow ctermbg=NONE   cterm=bold
  hi StatusLine    ctermfg=yellow  ctermbg=darkblue  cterm=NONE
  hi StatusLineNC  ctermfg=black   ctermbg=white     cterm=NONE
  hi TabLine       ctermfg=white   ctermbg=darkgrey  cterm=NONE
  hi TabLineFill   ctermfg=NONE    ctermbg=black     cterm=reverse
  hi TabLineSel    ctermfg=white   ctermbg=black     cterm=bold
  hi Title         ctermfg=magenta ctermbg=NONE      cterm=bold
  hi TitleBar      ctermfg=white   ctermbg=black     cterm=NONE
  hi TitleBarNC    ctermfg=grey    ctermbg=black     cterm=NONE
  hi Todo          ctermfg=black   ctermbg=darkyellow cterm=NONE
  hi ToolbarButton ctermfg=black   ctermbg=grey      cterm=bold
  hi ToolbarLine   ctermfg=NONE    ctermbg=black     cterm=NONE
  hi Type          ctermfg=darkgreen ctermbg=NONE    cterm=NONE
  hi Underlined    ctermfg=darkgreen ctermbg=NONE    cterm=underline
  hi VertSplit     ctermfg=black   ctermbg=white     cterm=NONE
  hi Visual        ctermfg=darkblue ctermbg=grey     cterm=NONE
  hi VisualNOS     ctermfg=NONE    ctermbg=black     cterm=underline
  hi WarningMsg    ctermfg=red     ctermbg=NONE      cterm=NONE
  hi WildMenu      ctermfg=black   ctermbg=yellow    cterm=NONE
  hi lCursor       ctermfg=black   ctermbg=white     cterm=NONE
  finish
endif

if s:t_Co >= 8
  hi Normal        ctermfg=grey
