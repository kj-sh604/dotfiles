" kijish.vim - dark pastel colorscheme
" derived from the dark pastel palette (qterminal / xfce4-terminal)
" https://github.com/kj-sh604/kijish-vim-theme

if exists('g:colors_name')
  highlight clear
endif

if exists('&termguicolors') && &termguicolors
  set termguicolors
endif

let g:colors_name = 'kijish'

" palette
let s:bg       = '#2c2c2c'
let s:fg       = '#dcdcdc'
let s:black    = '#3f3f3f'
let s:red      = '#d67979'
let s:green    = '#60b48a'
let s:yellow   = '#dfaf8f'
let s:blue     = '#9ab8d7'
let s:magenta  = '#dc8cc3'
let s:cyan     = '#8cd0d3'
let s:bblack   = '#709080'
let s:bred     = '#dca3a3'
let s:bgreen   = '#72d5a3'
let s:byellow  = '#f0dfaf'
let s:bblue    = '#94bff3'
let s:bmagenta = '#ec93d3'
let s:bcyan    = '#93e0e3'

" ui
let s:cursor    = '#69baa7'
let s:select    = '#4a4a4a'
let s:linehl    = '#333333'
let s:status    = '#303030'
let s:sidebar   = '#272727'
let s:deeper    = '#252525'
let s:border    = '#1e1e1e'
let s:lnr       = '#a9a9a9'
let s:punct     = '#b0b0b0'
let s:white     = '#ffffff'

" cterm 256 fallbacks
let s:cterm_bg    = 235
let s:cterm_fg    = 253
let s:cterm_black = 237
let s:cterm_red   = 174
let s:cterm_green = 72
let s:cterm_yellow= 180
let s:cterm_blue  = 146
let s:cterm_mag   = 175
let s:cterm_cyan  = 116
let s:cterm_bblack  = 66
let s:cterm_bred    = 181
let s:cterm_bgreen  = 114
let s:cterm_byellow = 223
let s:cterm_bblue   = 153
let s:cterm_bmagenta= 212
let s:cterm_bcyan   = 123
let s:cterm_select  = 239
let s:cterm_linehl  = 236
let s:cterm_lnr     = 248
let s:cterm_punct   = 247
let s:cterm_white   = 231

" helper
function! s:hi(group, fg, bg, attr, ...)
  let l:cmd = 'highlight ' . a:group
  let l:cmd .= ' guifg=' . (a:fg != '' ? a:fg : 'NONE')
  let l:cmd .= ' guibg=' . (a:bg != '' ? a:bg : 'NONE')
  let l:cmd .= ' gui='   . (a:attr != '' ? a:attr : 'NONE')
  let l:cmd .= ' ctermfg=' . (a:1 != '' ? a:1 : 'NONE')
  let l:cmd .= ' ctermbg=' . (a:2 != '' ? a:2 : 'NONE')
  let l:cmd .= ' cterm='   . (a:attr != '' ? a:attr : 'NONE')
  execute l:cmd
endfunction

" core
call s:hi('Normal', s:fg, s:bg, '', s:cterm_fg, s:cterm_bg)

" editor
call s:hi('Cursor',     s:bg,    s:cursor, '', s:cterm_bg,   '')
call s:hi('iCursor',    s:bg,    s:cursor, '', s:cterm_bg,   '')
call s:hi('CursorIM',   s:bg,    s:cursor, '', s:cterm_bg,   '')
call s:hi('CursorLine', '',       s:linehl, 'NONE', '',      s:cterm_linehl, 'NONE')
call s:hi('CursorColumn','',      s:linehl, 'NONE', '',      s:cterm_linehl, 'NONE')
call s:hi('ColorColumn','',       s:linehl, 'NONE', '',      s:cterm_linehl, 'NONE')

" line numbers
call s:hi('LineNr',     s:lnr,   s:bg, '', s:cterm_lnr, s:cterm_bg)
call s:hi('CursorLineNr', s:cyan, s:linehl, '', '', s:cterm_linehl)

" selection
call s:hi('Visual',     '',      s:select, '', '', s:cterm_select)
call s:hi('VisualNOS',  '',      s:select, 'undercurl', '', s:cterm_select, 'undercurl')

" search
call s:hi('Search',     s:yellow, s:select, 'bold', s:cterm_fg, s:cterm_select, 'bold')
call s:hi('IncSearch',  s:yellow, s:select, 'bold', s:cterm_fg, s:cterm_select, 'bold')

" matching
call s:hi('MatchParen', s:cyan, s:linehl, 'bold', '', s:cterm_linehl, 'bold')

" splits and status
call s:hi('VertSplit',  s:border, s:border, '', s:cterm_bg, s:cterm_bg)
call s:hi('StatusLine', s:white, s:status, 'bold', s:cterm_white, s:cterm_fg, 'bold')
call s:hi('StatusLineNC', s:bblack, s:status, '', s:cterm_bblack, s:cterm_bg)

" tabline
call s:hi('TabLine',     s:bblack, s:deeper, '', s:cterm_bblack, s:cterm_bg)
call s:hi('TabLineFill', '',       s:deeper, '', '', s:cterm_bg)
call s:hi('TabLineSel',  s:fg,    s:bg, 'bold', s:cterm_fg, s:cterm_bg, 'bold')

" pmenu
call s:hi('Pmenu',     s:fg,    s:sidebar, '', s:cterm_fg, 236)
call s:hi('PmenuSel',  s:fg,    s:select,  'bold', s:cterm_fg, s:cterm_select, 'bold')
call s:hi('PmenuSbar', '',       s:sidebar, '', '', 236)
call s:hi('PmenuThumb','',       s:bblack,  '', '', s:cterm_bblack)

" wildmenu
call s:hi('WildMenu',  s:fg, s:select, 'bold', s:cterm_fg, s:cterm_select, 'bold')

" messages
call s:hi('ErrorMsg',  s:red,   s:bg, 'bold', s:cterm_red, s:cterm_bg, 'bold')
call s:hi('WarningMsg', s:yellow, s:bg, '', s:cterm_yellow, s:cterm_bg)
call s:hi('MoreMsg',   s:green, s:bg, 'bold', s:cterm_green, s:cterm_bg, 'bold')
call s:hi('ModeMsg',   s:fg,    s:bg, 'bold', s:cterm_fg, s:cterm_bg, 'bold')
call s:hi('Question',  s:cyan,  s:bg, '', s:cterm_cyan, s:cterm_bg)

" special
call s:hi('SpecialKey',   s:bblack, s:bg, '', s:cterm_bblack, s:cterm_bg)
call s:hi('NonText',      s:bblack, s:bg, '', s:cterm_bblack, s:cterm_bg)
call s:hi('EndOfBuffer',  s:bblack, s:bg, '', s:cterm_bblack, s:cterm_bg)
call s:hi('Directory',    s:blue,   s:bg, '', s:cterm_blue, s:cterm_bg)
call s:hi('Title',        s:magenta, s:bg, 'bold', s:cterm_mag, s:cterm_bg, 'bold')
call s:hi('Conceal',      s:bblack, s:bg, '', s:cterm_bblack, s:cterm_bg)

" signs and folds
call s:hi('SignColumn',  s:bblack, s:bg, '', s:cterm_bblack, s:cterm_bg)
call s:hi('FoldColumn',  s:bblack, s:bg, '', s:cterm_bblack, s:cterm_bg)
call s:hi('Folded',      s:bblack, s:deeper, '', s:cterm_bblack, s:cterm_bg)

" diff
call s:hi('DiffAdd',    s:green,  s:select, '', s:cterm_green, s:cterm_select)
call s:hi('DiffChange', s:yellow, s:select, '', s:cterm_yellow, s:cterm_select)
call s:hi('DiffDelete', s:red,    s:bg, 'bold', s:cterm_red, s:cterm_bg, 'bold')
call s:hi('DiffText',   s:fg,     s:select, 'bold', s:cterm_fg, s:cterm_select, 'bold')

" spell
call s:hi('SpellBad',   s:red,   '', 'undercurl', s:cterm_red, '', 'undercurl')
call s:hi('SpellCap',   s:blue,  '', 'undercurl', s:cterm_blue, '', 'undercurl')
call s:hi('SpellLocal', s:cyan,  '', 'undercurl', s:cterm_cyan, '', 'undercurl')
call s:hi('SpellRare',  s:magenta, '', 'undercurl', s:cterm_mag, '', 'undercurl')

" =========================
" syntax groups
" =========================

" comments
call s:hi('Comment', s:bblack, '', '', s:cterm_bblack, '')
call s:hi('SpecialComment', s:bblack, '', 'bold', s:cterm_bblack, '', 'bold')

" constants
call s:hi('Constant',    s:byellow, '', '', s:cterm_byellow, '')
call s:hi('String',      s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('Character',   s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('Number',      s:byellow, '', '', s:cterm_byellow, '')
call s:hi('Boolean',     s:byellow, '', '', s:cterm_byellow, '')
call s:hi('Float',       s:byellow, '', '', s:cterm_byellow, '')

" identifiers
call s:hi('Identifier', s:fg, '', '', s:cterm_fg, '')
call s:hi('Function',   s:cyan, '', '', s:cterm_cyan, '')

" statements
call s:hi('Statement',    s:bblue, '', '', s:cterm_bblue, '')
call s:hi('Conditional',  s:bblue, '', '', s:cterm_bblue, '')
call s:hi('Repeat',       s:bblue, '', '', s:cterm_bblue, '')
call s:hi('Label',        s:byellow, '', '', s:cterm_byellow, '')
call s:hi('Operator',     s:fg, '', '', s:cterm_fg, '')
call s:hi('Keyword',      s:bblue, '', '', s:cterm_bblue, '')
call s:hi('Exception',    s:bblue, '', '', s:cterm_bblue, '')

" preprocessor
call s:hi('PreProc',   s:magenta, '', '', s:cterm_mag, '')
call s:hi('Include',   s:magenta, '', '', s:cterm_mag, '')
call s:hi('Define',    s:magenta, '', '', s:cterm_mag, '')
call s:hi('Macro',     s:magenta, '', '', s:cterm_mag, '')
call s:hi('PreCondit', s:magenta, '', '', s:cterm_mag, '')

" types
call s:hi('Type',         s:blue, '', '', s:cterm_blue, '')
call s:hi('StorageClass', s:bblue, '', '', s:cterm_bblue, '')
call s:hi('Structure',    s:bcyan, '', '', s:cterm_bcyan, '')
call s:hi('Typedef',      s:blue, '', '', s:cterm_blue, '')

" special
call s:hi('Special',       s:bcyan,  '', '', s:cterm_bcyan, '')
call s:hi('SpecialChar',   s:bcyan,  '', '', s:cterm_bcyan, '')
call s:hi('Tag',           s:red,    '', '', s:cterm_red, '')
call s:hi('Delimiter',     s:punct,  '', '', s:cterm_punct, '')
call s:hi('Debug',         s:red,    '', '', s:cterm_red, '')

" errors and todos
call s:hi('Error',  s:red, s:bg, 'bold', s:cterm_red, s:cterm_bg, 'bold')
call s:hi('Todo',   s:yellow, s:bg, 'bold', s:cterm_yellow, s:cterm_bg, 'bold')

" misc
call s:hi('Underlined', s:fg, '', 'underline', s:cterm_fg, '', 'underline')
call s:hi('Ignore',    s:bblack, '', '', s:cterm_bblack, '')

" =========================
" language specific
" =========================

" html/xml tags
call s:hi('htmlTag',   s:punct,  '', '', s:cterm_punct, '')
call s:hi('htmlEndTag', s:punct, '', '', s:cterm_punct, '')
call s:hi('htmlTagName', s:red,  '', '', s:cterm_red, '')
call s:hi('htmlArg',   s:magenta, '', '', s:cterm_mag, '')
call s:hi('xmlTag',    s:punct,  '', '', s:cterm_punct, '')
call s:hi('xmlEndTag', s:punct,  '', '', s:cterm_punct, '')
call s:hi('xmlTagName', s:red,   '', '', s:cterm_red, '')

" css
call s:hi('cssClassName', s:red,     '', '', s:cterm_red, '')
call s:hi('cssIdentifier', s:yellow, '', '', s:cterm_yellow, '')
call s:hi('cssBraces',    s:punct,   '', '', s:cterm_punct, '')
call s:hi('cssTagName',   s:red,     '', '', s:cterm_red, '')

" javascript/typescript
call s:hi('jsFuncCall',  s:cyan, '', '', s:cterm_cyan, '')
call s:hi('jsFuncArgs',  s:bred, '', '', s:cterm_bred, '')
call s:hi('jsThis',      s:bblue, '', 'italic', s:cterm_bblue, '', 'italic')
call s:hi('typescriptBraces', s:punct, '', '', s:cterm_punct, '')

" python
call s:hi('pythonBuiltin', s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('pythonSelf',    s:bblue, '', 'italic', s:cterm_bblue, '', 'italic')
call s:hi('pythonDecorator', s:magenta, '', '', s:cterm_mag, '')

" go
call s:hi('goPackage',  s:bblue, '', '', s:cterm_bblue, '')
call s:hi('goImport',   s:bblue, '', '', s:cterm_bblue, '')
call s:hi('goFunc',     s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('goStruct',   s:blue,  '', '', s:cterm_blue, '')

" rust
call s:hi('rustSelf',       s:bblue, '', 'italic', s:cterm_bblue, '', 'italic')
call s:hi('rustFuncCall',   s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('rustModPath',    s:blue,  '', '', s:cterm_blue, '')
call s:hi('rustAttribute',  s:magenta, '', '', s:cterm_mag, '')

" shell
call s:hi('shVariable',  s:fg, '', '', s:cterm_fg, '')
call s:hi('shFunction',  s:cyan, '', '', s:cterm_cyan, '')
call s:hi('shDeref',     s:bcyan, '', '', s:cterm_bcyan, '')

" vim
call s:hi('vimCommand',    s:bblue, '', '', s:cterm_bblue, '')
call s:hi('vimVar',        s:fg,    '', '', s:cterm_fg, '')
call s:hi('vimFuncName',   s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('vimIsCommand',  s:fg,    '', '', s:cterm_fg, '')
call s:hi('vimUserFunc',   s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('vimAutoCmd',    s:bblue, '', '', s:cterm_bblue, '')
call s:hi('vimAutoEvent',  s:byellow, '', '', s:cterm_byellow, '')
call s:hi('vimHiGroup',    s:byellow, '', '', s:cterm_byellow, '')
call s:hi('vimHighlight',  s:magenta, '', '', s:cterm_mag, '')

" markdown
call s:hi('markdownH1',  s:bblue,  '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH2',  s:bblue,  '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH3',  s:bblue,  '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH4',  s:bblue,  '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH5',  s:bblue,  '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH6',  s:bblue,  '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownBold', s:byellow, '', 'bold', s:cterm_byellow, '', 'bold')
call s:hi('markdownItalic', s:bred, '', 'italic', s:cterm_bred, '', 'italic')
call s:hi('markdownCode', s:bcyan,  '', '', s:cterm_bcyan, '')
call s:hi('markdownLink', s:blue,   '', '', s:cterm_blue, '')
call s:hi('markdownUrl',  s:blue,   '', 'underline', s:cterm_blue, '', 'underline')
call s:hi('markdownBlockquote', s:bblack, '', '', s:cterm_bblack, '')
call s:hi('markdownListMarker', s:red, '', '', s:cterm_red, '')

" git
call s:hi('gitcommitSummary', s:fg, '', 'bold', s:cterm_fg, '', 'bold')
call s:hi('gitcommitComment', s:bblack, '', '', s:cterm_bblack, '')
call s:hi('diffAdded',   s:green,  '', '', s:cterm_green, '')
call s:hi('diffRemoved', s:red,    '', '', s:cterm_red, '')
call s:hi('diffChanged', s:yellow, '', '', s:cterm_yellow, '')

" json
call s:hi('jsonKeyword', s:blue, '', '', s:cterm_blue, '')
call s:hi('jsonString',  s:bgreen, '', '', s:cterm_bgreen, '')
call s:hi('jsonNumber',  s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsonBoolean', s:byellow, '', '', s:cterm_byellow, '')

" yaml
call s:hi('yamlKey', s:blue, '', '', s:cterm_blue, '')

" toml
call s:hi('tomlTable',  s:blue, '', '', s:cterm_blue, '')
call s:hi('tomlKey',    s:blue, '', '', s:cterm_blue, '')

" =========================
" terminal (neovim)
" =========================
if has('nvim')
  let g:terminal_color_0  = s:black
  let g:terminal_color_1  = s:red
  let g:terminal_color_2  = s:green
  let g:terminal_color_3  = s:yellow
  let g:terminal_color_4  = s:blue
  let g:terminal_color_5  = s:magenta
  let g:terminal_color_6  = s:cyan
  let g:terminal_color_7  = s:fg
  let g:terminal_color_8  = s:bblack
  let g:terminal_color_9  = s:bred
  let g:terminal_color_10 = s:bgreen
  let g:terminal_color_11 = s:byellow
  let g:terminal_color_12 = s:bblue
  let g:terminal_color_13 = s:bmagenta
  let g:terminal_color_14 = s:bcyan
  let g:terminal_color_15 = s:white
endif

" clean up
delfunction s:hi
