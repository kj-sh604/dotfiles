" Poimandres Theme: {{{
"
" https://github.com/zenorocha/Poimandres-theme
"
" Copyright 2016, All rights reserved
"
" Code licensed under the MIT license
" http://zenorocha.mit-license.org
"
" @author Trevor Heins <@heinst>
" @author Éverton Ribeiro <nuxlli@gmail.com>
" @author Derek Sifford <dereksifford@gmail.com>
" @author Zeno Rocha <hi@zenorocha.com>
scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'Poimandres'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

let s:fg        = g:poimandres#palette.fg

let s:bglighter = g:poimandres#palette.bglighter
let s:bglight   = g:poimandres#palette.bglight
let s:bg        = g:poimandres#palette.bg
let s:bgdark    = g:poimandres#palette.bgdark
let s:bgdarker  = g:poimandres#palette.bgdarker

let s:comment   = g:poimandres#palette.comment
let s:selection = g:poimandres#palette.selection
let s:subtle    = g:poimandres#palette.subtle

let s:cyan      = g:poimandres#palette.cyan
let s:green     = g:poimandres#palette.green
let s:orange    = g:poimandres#palette.orange
let s:pink      = g:poimandres#palette.pink
let s:purple    = g:poimandres#palette.purple
let s:red       = g:poimandres#palette.red
let s:yellow    = g:poimandres#palette.yellow

let s:brightYellow = g:poimandres#palette.brightYellow
let s:brightMint = g:poimandres#palette.brightMint
let s:lowerMint = g:poimandres#palette.lowerMint
let s:blueishGreen = g:poimandres#palette.blueishGreen
let s:lowerBlue = g:poimandres#palette.lowerBlue
let s:lightBlue = g:poimandres#palette.lightBlue
let s:desaturatedBlue = g:poimandres#palette.desaturatedBlue
let s:bluishGrayBrighter = g:poimandres#palette.bluishGrayBrighter
let s:hotRed = g:poimandres#palette.hotRed
let s:brighterPink = g:poimandres#palette.brighterPink
let s:gray = g:poimandres#palette.gray
let s:darkerGray = g:poimandres#palette.darkerGray
let s:bluishGray = g:poimandres#palette.bluishGray

let s:none      = ['NONE', 'NONE']

if has('nvim')
  for s:i in range(16)
    let g:terminal_color_{s:i} = g:poimandres#palette['color_' . s:i]
  endfor
endif

if has('terminal')
  let g:terminal_ansi_colors = []
  for s:i in range(16)
    call add(g:terminal_ansi_colors, g:poimandres#palette['color_' . s:i])
  endfor
endif

" }}}2
" User Configuration: {{{2

if !exists('g:poimandres_bold')
  let g:poimandres_bold = 1
endif

if !exists('g:poimandres_italic')
  let g:poimandres_italic = 1
endif

if !exists('g:poimandres_underline')
  let g:poimandres_underline = 1
endif

if !exists('g:poimandres_undercurl')
  let g:poimandres_undercurl = g:poimandres_underline
endif

if !exists('g:poimandres_inverse')
  let g:poimandres_inverse = 1
endif

if !exists('g:poimandres_colorterm')
  let g:poimandres_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:poimandres_bold == 1 ? 'bold' : 0,
      \ 'italic': g:poimandres_italic == 1 ? 'italic' : 0,
      \ 'underline': g:poimandres_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:poimandres_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:poimandres_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

"}}}2
" Poimandres Highlight Groups: {{{2

call s:h('PoimandresBgLight', s:none, s:bglight)
call s:h('PoimandresBgLighter', s:none, s:bglighter)
call s:h('PoimandresBgDark', s:none, s:bgdark)
call s:h('PoimandresBgDarker', s:none, s:bgdarker)

call s:h('PoimandresFg', s:fg)
call s:h('PoimandresFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('PoimandresFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('PoimandresComment', s:comment)
call s:h('PoimandresCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('PoimandresSelection', s:none, s:selection)

call s:h('PoimandresSubtle', s:subtle)

call s:h('PoimandresCyan', s:cyan)
call s:h('PoimandresCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('PoimandresGreen', s:green)
call s:h('PoimandresGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('PoimandresGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('PoimandresGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('PoimandresOrange', s:orange)
call s:h('PoimandresOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('PoimandresOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('PoimandresOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('PoimandresOrangeInverse', s:bg, s:orange)

call s:h('PoimandresPink', s:pink)
call s:h('PoimandresPinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('PoimandresPurple', s:purple)
call s:h('PoimandresPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('PoimandresPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('PoimandresRed', s:hotRed)
call s:h('PoimandresRedInverse', s:fg, s:hotRed)

call s:h('PoimandresYellow', s:brightYellow)
call s:h('PoimandresYellowItalic', s:brightYellow, s:none, [s:attrs.italic])

call s:h('PoimandresError', s:hotRed, s:none, [], s:hotRed)

call s:h('PoimandresErrorLine', s:none, s:none, [s:attrs.undercurl], s:hotRed)
call s:h('PoimandresWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('PoimandresInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('PoimandresTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('PoimandresSearch', s:green, s:none, [s:attrs.inverse])
call s:h('PoimandresBoundary', s:comment, s:bgdark)
call s:h('PoimandresLink', s:cyan, s:none, [s:attrs.underline])

call s:h('PoimandresDiffChange', s:orange, s:none)
call s:h('PoimandresDiffText', s:bg, s:orange)
call s:h('PoimandresDiffDelete', s:hotRed, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, g:poimandres_colorterm || has('gui_running') ? s:bg : s:none )
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  PoimandresBgDark
hi! link CursorColumn CursorLine
hi! link CursorLineNr PoimandresYellow
hi! link DiffAdd      PoimandresGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   PoimandresDiffChange
hi! link DiffDelete   PoimandresDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     PoimandresDiffText
hi! link Directory    PoimandresPurpleBold
hi! link ErrorMsg     PoimandresRedInverse
hi! link FoldColumn   PoimandresSubtle
hi! link Folded       PoimandresBoundary
hi! link IncSearch    PoimandresOrangeInverse
call s:h('LineNr', s:comment)
hi! link MoreMsg      PoimandresFgBold
hi! link NonText      PoimandresSubtle
hi! link Pmenu        PoimandresBgDark
hi! link PmenuSbar    PoimandresBgDark
hi! link PmenuSel     PoimandresSelection
hi! link PmenuThumb   PoimandresSelection
hi! link Question     PoimandresFgBold
hi! link Search       PoimandresSearch
call s:h('SignColumn', s:comment)
hi! link TabLine      PoimandresBoundary
hi! link TabLineFill  PoimandresBgDarker
hi! link TabLineSel   Normal
hi! link Title        PoimandresGreenBold
hi! link VertSplit    PoimandresBoundary
hi! link Visual       PoimandresSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   PoimandresOrangeInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:cyan, s:none)

" Neovim uses SpecialKey for escape characters only. Vim uses it for that, plus whitespace.
if has('nvim')
  hi! link SpecialKey PoimandresRed
  hi! link LspReferenceText PoimandresSelection
  hi! link LspReferenceRead PoimandresSelection
  hi! link LspReferenceWrite PoimandresSelection
  hi! link LspDiagnosticsDefaultInformation PoimandresCyan
  hi! link LspDiagnosticsDefaultHint PoimandresCyan
  hi! link LspDiagnosticsDefaultError PoimandresError
  hi! link LspDiagnosticsDefaultWarning PoimandresOrange
  hi! link LspDiagnosticsUnderlineError PoimandresErrorLine
  hi! link LspDiagnosticsUnderlineHint PoimandresInfoLine
  hi! link LspDiagnosticsUnderlineInformation PoimandresInfoLine
  hi! link LspDiagnosticsUnderlineWarning PoimandresWarnLine
else
  hi! link SpecialKey PoimandresSubtle
endif

hi! link Comment PoimandresComment
hi! link Underlined PoimandresFgUnderline
hi! link Todo PoimandresTodo

hi! link Error PoimandresError
hi! link SpellBad PoimandresErrorLine
hi! link SpellLocal PoimandresWarnLine
hi! link SpellCap PoimandresInfoLine
hi! link SpellRare PoimandresInfoLine

hi! link Constant PoimandresPurple
hi! link String PoimandresYellow
hi! link Character PoimandresPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier PoimandresFg
hi! link Function PoimandresGreen

hi! link Statement PoimandresPink
hi! link Conditional PoimandresPink
hi! link Repeat PoimandresPink
hi! link Label PoimandresPink
hi! link Operator PoimandresPink
hi! link Keyword PoimandresPink
hi! link Exception PoimandresPink

hi! link PreProc PoimandresPink
hi! link Include PoimandresPink
hi! link Define PoimandresPink
hi! link Macro PoimandresPink
hi! link PreCondit PoimandresPink
hi! link StorageClass PoimandresPink
hi! link Structure PoimandresPink
hi! link Typedef PoimandresPink

hi! link Type PoimandresCyanItalic

hi! link Delimiter PoimandresFg

hi! link Special PoimandresPink
hi! link SpecialComment PoimandresCyanItalic
hi! link Tag PoimandresCyan
hi! link helpHyperTextJump PoimandresLink
hi! link helpCommand PoimandresPurple
hi! link helpExample PoimandresGreen
hi! link helpBacktick Special

"}}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0 et:
