" kijish.vim - dark pastel colorscheme
" derived from the dark pastel palette (qterminal / xfce4-terminal)
" https://github.com/kj-sh604/kijish-vim-theme

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
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

" optional italic and bold
let Italic = ""
if exists('g:kijish_italic')
  let Italic = "italic"
endif

let Bold = ""
if exists('g:kijish_bold')
  let Bold = "bold"
endif

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
call s:hi('ColorColumn',   '',       s:linehl, 'NONE', '',      s:cterm_linehl, 'NONE')
call s:hi('CursorColumn',  '',       s:linehl, 'NONE', '',      s:cterm_linehl, 'NONE')
call s:hi('CursorLine',    '',       s:linehl, 'NONE', '',      s:cterm_linehl, 'NONE')
call s:hi('Cursor',        s:bg,     s:cursor, '', s:cterm_bg,   '')
call s:hi('iCursor',       s:bg,     s:cursor, '', s:cterm_bg,   '')
call s:hi('CursorIM',      s:bg,     s:cursor, '', s:cterm_bg,   '')
call s:hi('CursorLineNr',  s:cyan,   '',       '', s:cterm_cyan, '')
call s:hi('Directory',     s:blue,   '',       '', s:cterm_blue, '')

" diff
call s:hi('DiffAdd',    '',       s:select, '',      '', s:cterm_select)
call s:hi('DiffChange', '',       s:select, '',      '', s:cterm_select)
call s:hi('DiffDelete', s:red,    s:black,  '',      s:cterm_red, s:cterm_black)
call s:hi('DiffText',   '',       '',       'reverse', '', '', 'reverse')

" messages
call s:hi('ErrorMsg',   s:red,    '', 'reverse', s:cterm_red, '', 'reverse')
call s:hi('WarningMsg', s:red,    '', '',        s:cterm_red, '')

" splits
call s:hi('VertSplit', s:border, s:border, '', s:cterm_bg, s:cterm_bg)

" folds
call s:hi('Folded',     s:bblack, s:deeper, '', s:cterm_bblack, s:cterm_bg)
call s:hi('FoldColumn', s:bblack, s:deeper, '', s:cterm_bblack, s:cterm_bg)

" signs
call s:hi('SignColumn', s:bblack, s:bg, '', s:cterm_bblack, s:cterm_bg)

" search
call s:hi('IncSearch', s:white,  '',       'bold,reverse', s:cterm_white, '', 'bold,reverse')
call s:hi('LineNr',    s:lnr,    '',       '', s:cterm_lnr, '')
call s:hi('MatchParen',s:red,    '',       'bold', s:cterm_red, '', 'bold')
call s:hi('NonText',   s:lnr,    '',       '', s:cterm_lnr, '')
call s:hi('Pmenu',     s:fg,     s:select, '', s:cterm_fg, s:cterm_select)
call s:hi('PmenuSel',  s:select, s:yellow, '', s:cterm_select, s:cterm_yellow)
call s:hi('PmenuSbar', s:select, s:select, '', s:cterm_select, s:cterm_select)
call s:hi('PmenuThumb',s:yellow, s:yellow, '', s:cterm_yellow, s:cterm_yellow)
call s:hi('Question',  s:yellow, '',       '', s:cterm_yellow, '')
call s:hi('Search',    s:white,  '',       'underline,bold', s:cterm_white, '', 'underline,bold')
call s:hi('SpecialKey',s:lnr,    '',       '', s:cterm_lnr, '')
call s:hi('SpellBad',  s:red,    '',       '', s:cterm_red, '')
call s:hi('SpellLocal',s:yellow, '',       '', s:cterm_yellow, '')
call s:hi('SpellCap',  s:byellow,'',       '', s:cterm_byellow, '')
call s:hi('SpellRare', s:cyan,   '',       '', s:cterm_cyan, '')

" status
call s:hi('StatusLine',   s:bg,  s:bblack, 'bold', s:cterm_bg, s:cterm_bblack, 'bold')
call s:hi('StatusLineNC', s:bblack, s:lnr, '', s:cterm_bblack, s:cterm_lnr, '')

" tabline
call s:hi('TabLine',     s:bblack, s:lnr,   '', s:cterm_bblack, s:cterm_lnr, '')
call s:hi('TabLineFill', '',       s:lnr,   '', '', s:cterm_lnr, '')
call s:hi('TabLineSel',  s:yellow, '',      'bold', s:cterm_yellow, '', 'bold')

" title and visual
call s:hi('Title',     s:blue, '',       'bold', s:cterm_blue, '', 'bold')
call s:hi('Visual',    '',     s:black,  'bold', '', s:cterm_black, 'bold')
call s:hi('VisualNOS', '',     s:black,  'bold', '', s:cterm_black, 'bold')

" wildmenu
call s:hi('WildMenu', s:bg, s:yellow, 'bold', s:cterm_bg, s:cterm_yellow, 'bold')

" comments
call s:hi('Comment',        s:bblack, '', '', s:cterm_bblack, '')
call s:hi('SpecialComment', s:bblack, '', 'bold', s:cterm_bblack, '', 'bold')

" constants
call s:hi('Constant',  s:byellow, '', '', s:cterm_byellow, '')
call s:hi('String',    s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('Character', s:byellow, '', '', s:cterm_byellow, '')
call s:hi('Boolean',   s:byellow, '', '', s:cterm_byellow, '')
call s:hi('Number',    s:byellow, '', '', s:cterm_byellow, '')
call s:hi('Float',     s:byellow, '', '', s:cterm_byellow, '')

" identifiers
call s:hi('Identifier', s:blue, '', '', s:cterm_blue, '')
call s:hi('Function',   s:blue, '', '', s:cterm_blue, '')

" statements
call s:hi('Statement',   s:blue,    '', '', s:cterm_blue, '')
call s:hi('Conditional', s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('Operator',    s:red,     '', '', s:cterm_red, '')
call s:hi('Exception',   s:red,     '', '', s:cterm_red, '')
call s:hi('Repeat',      s:bblue,   '', '', s:cterm_bblue, '')
call s:hi('Label',       s:byellow, '', '', s:cterm_byellow, '')
call s:hi('Keyword',     s:bblue,   '', '', s:cterm_bblue, '')

" preprocessor
call s:hi('PreProc',   s:yellow, '', '', s:cterm_yellow, '')
call s:hi('Include',   s:magenta,'', '', s:cterm_mag, '')
call s:hi('Define',    s:magenta,'', '', s:cterm_mag, '')
call s:hi('Macro',     s:magenta,'', '', s:cterm_mag, '')
call s:hi('PreCondit', s:magenta,'', '', s:cterm_mag, '')

" types
call s:hi('Type',         s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('StorageClass', s:bblue, '', '', s:cterm_bblue, '')
call s:hi('Structure',    s:bcyan, '', '', s:cterm_bcyan, '')
call s:hi('Typedef',      s:blue,  '', '', s:cterm_blue, '')

" special
call s:hi('Special',     s:cyan,   '', '', s:cterm_cyan, '')
call s:hi('SpecialChar', s:bcyan,  '', '', s:cterm_bcyan, '')
call s:hi('Tag',         s:red,    '', '', s:cterm_red, '')
call s:hi('Delimiter',   s:punct,  '', '', s:cterm_punct, '')
call s:hi('Debug',       s:red,    '', '', s:cterm_red, '')

" errors and todos
call s:hi('Error', s:fg,    s:red, '', s:cterm_fg, s:cterm_red)
call s:hi('Todo',  s:red,   '',    'bold', s:cterm_red, '', 'bold')

" misc
call s:hi('Underlined', '', '', 'underline', '', '', 'underline')
call s:hi('Ignore',     s:bblack, '', '', s:cterm_bblack, '')

" coc
call s:hi('CocErrorSign',   s:red,     '', '', s:cterm_red, '')
call s:hi('CocWarningSign', s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('CocHintSign',    s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('CocInfoSign',    s:byellow, '', '', s:cterm_byellow, '')

" css
call s:hi('cssVendor',          s:red,     '', '', s:cterm_red, '')
call s:hi('cssTagName',         s:red,     '', '', s:cterm_red, '')
call s:hi('cssAttrComma',      s:fg,      '', '', s:cterm_fg, '')
call s:hi('cssBackgroundProp', s:blue,    '', '', s:cterm_blue, '')
call s:hi('cssBorderProp',     s:blue,    '', '', s:cterm_blue, '')
call s:hi('cssBoxProp',        s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('cssDimensionProp',  s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('cssFontProp',       s:blue,    '', '', s:cterm_blue, '')
call s:hi('cssPositioningProp',s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('cssTextProp',       s:blue,    '', '', s:cterm_blue, '')
call s:hi('cssValueLength',    s:fg,      '', '', s:cterm_fg, '')
call s:hi('cssValueInteger',   s:fg,      '', '', s:cterm_fg, '')
call s:hi('cssValueNumber',    s:fg,      '', '', s:cterm_fg, '')
call s:hi('cssIdentifier',     s:green,   '', '', s:cterm_green, '')
call s:hi('cssIncludeKeyword', s:byellow, '', '', s:cterm_byellow, '')
call s:hi('cssImportant',      s:red,     '', '', s:cterm_red, '')
call s:hi('cssClassName',      s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('cssClassNameDot',   s:fg,      '', '', s:cterm_fg, '')
call s:hi('cssProp',           s:blue,    '', '', s:cterm_blue, '')
call s:hi('cssAttr',           s:fg,      '', '', s:cterm_fg, '')
call s:hi('cssUnitDecorators', s:fg,      '', '', s:cterm_fg, '')
call s:hi('cssNoise',          s:red,     '', '', s:cterm_red, '')

" diff (extended)
call s:hi('diffRemoved', s:red,     '', '', s:cterm_red, '')
call s:hi('diffChanged', s:blue,    '', '', s:cterm_blue, '')
call s:hi('diffAdded',   s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('diffSubname', s:green,   '', '', s:cterm_green, '')

" elm
call s:hi('elmDelimiter', s:fg,  '', '', s:cterm_fg, '')
call s:hi('elmOperator',  s:red, '', '', s:cterm_red, '')

" fugitive
call s:hi('FugitiveblameHash',           s:blue,    '', '', s:cterm_blue, '')
call s:hi('FugitiveblameUncommitted',    s:red,     '', '', s:cterm_red, '')
call s:hi('FugitiveblameTime',           s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('FugitiveblameNotCommittedYet',s:byellow, '', '', s:cterm_byellow, '')

" git
call s:hi('gitcommitSummary',          s:fg,      '', 'bold', s:cterm_fg, '', 'bold')
call s:hi('gitcommitComment',          s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('gitcommitBranch',           s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('gitcommitDiscardedType',    s:red,     '', '', s:cterm_red, '')
call s:hi('gitcommitSelectedType',     s:green,   '', '', s:cterm_green, '')
call s:hi('gitcommitHeader',           s:blue,    '', '', s:cterm_blue, '')
call s:hi('gitcommitUntrackedFile',    s:byellow, '', '', s:cterm_byellow, '')
call s:hi('gitcommitDiscardedFile',    s:red,     '', '', s:cterm_red, '')
call s:hi('gitcommitSelectedFile',     s:yellow,  '', '', s:cterm_yellow, '')

" help
call s:hi('helpHyperTextEntry', s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('helpHeadline',       s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('helpSectionDelim',   s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('helpNote',           s:red,     '', '', s:cterm_red, '')

" javascript
call s:hi('javaScriptOperator',     s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('javaScriptBraces',       s:blue,    '', '', s:cterm_blue, '')
call s:hi('javaScriptNull',         s:byellow, '', '', s:cterm_byellow, '')
call s:hi('javaScriptOpSymbols',    s:red,     '', '', s:cterm_red, '')
call s:hi('javaScriptParens',       s:blue,    '', '', s:cterm_blue, '')
call s:hi('javaScriptDocTags',      s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('javaScriptDocSeeTag',    s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('javaScriptBrowserObjects',s:cyan,   '', '', s:cterm_cyan, '')
call s:hi('javaScriptDOMObjects',   s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('javaScriptFuncArg',      s:byellow, '', '', s:cterm_byellow, '')
call s:hi('javascriptOpSymbol',     s:red,     '', '', s:cterm_red, '')
call s:hi('javascriptDocNotation',  s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('javascriptDocNamedParamType', s:bblack, '', '', s:cterm_bblack, '')
call s:hi('javascriptDocParamName', s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('javascriptDocParamType', s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('javascriptTemplateSB',   s:red,     '', '', s:cterm_red, '')
call s:hi('javascriptRepeat',       s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('javascriptObjectLabelColon', s:red,  '', '', s:cterm_red, '')
call s:hi('javascriptObjectMethodName', s:yellow,'', '', s:cterm_yellow, '')
call s:hi('javascriptFuncName',     s:yellow,  '', '', s:cterm_yellow, '')

" json
call s:hi('jsonEscape',      s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('jsonNumber',      s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsonBraces',      s:fg,      '', '', s:cterm_fg, '')
call s:hi('jsonNull',        s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsonBoolean',     s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsonKeyword',     s:blue,    '', '', s:cterm_blue, '')
call s:hi('jsonString',      s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('jsonKeywordMatch',s:red,     '', '', s:cterm_red, '')
call s:hi('jsonQuote',       s:fg,      '', '', s:cterm_fg, '')
call s:hi('jsonNoise',       s:red,     '', '', s:cterm_red, '')

" markdown
call s:hi('markdownH1',                 s:blue,    '', 'bold', s:cterm_blue, '', 'bold')
call s:hi('markdownH2',                 s:bblue,   '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH3',                 s:bblue,   '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH4',                 s:bblue,   '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH5',                 s:bblue,   '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownH6',                 s:bblue,   '', 'bold', s:cterm_bblue, '', 'bold')
call s:hi('markdownBold',              s:byellow, '', 'bold', s:cterm_byellow, '', 'bold')
call s:hi('markdownItalic',            s:bred,    '', 'italic', s:cterm_bred, '', 'italic')
call s:hi('markdownHeadingRule',       s:red,     '', 'bold', s:cterm_red, '', 'bold')
call s:hi('markdownHeadingDelimiter',  s:red,     '', 'bold', s:cterm_red, '', 'bold')
call s:hi('markdownListMarker',        s:byellow, '', '', s:cterm_byellow, '')
call s:hi('markdownBlockquote',        s:byellow, '', '', s:cterm_byellow, '')
call s:hi('markdownRule',              s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('markdownLinkText',          s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('markdownLinkTextDelimiter', s:blue,    '', '', s:cterm_blue, '')
call s:hi('markdownLinkDelimiter',     s:blue,    '', '', s:cterm_blue, '')
call s:hi('markdownIdDeclaration',     s:green,   '', '', s:cterm_green, '')
call s:hi('markdownAutomaticLink',     s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('markdownUrl',               s:cyan,    '', 'underline', s:cterm_cyan, '', 'underline')
call s:hi('markdownUrlTitle',          s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('markdownUrlDelimiter',      s:byellow, '', '', s:cterm_byellow, '')
call s:hi('markdownUrlTitleDelimiter', s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('markdownCodeDelimiter',     s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('markdownCode',              s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('markdownEscape',            s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('markdownError',             s:red,     '', '', s:cterm_red, '')
call s:hi('markdownLink',              s:blue,    '', '', s:cterm_blue, '')

" nerdtree
call s:hi('NERDTreeHelp',         s:fg,      '', '', s:cterm_fg, '')
call s:hi('NERDTreeHelpKey',      s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('NERDTreeHelpCommand',  s:byellow, '', '', s:cterm_byellow, '')
call s:hi('NERDTreeHelpTitle',    s:blue,    '', '', s:cterm_blue, '')
call s:hi('NERDTreeUp',           s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('NERDTreeCWD',          s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('NERDTreeOpenable',     s:red,     '', '', s:cterm_red, '')
call s:hi('NERDTreeClosable',     s:byellow, '', '', s:cterm_byellow, '')

" pug
call s:hi('pugJavascriptOutputChar', s:byellow, '', '', s:cterm_byellow, '')

" typescript
call s:hi('typescriptParens',             s:blue,    '', '', s:cterm_blue, '')
call s:hi('typescriptLogicSymbols',       s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptReserved',           s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('typescriptLabel',              s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('typescriptFuncName',           s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('typescriptCall',               s:byellow, '', '', s:cterm_byellow, '')
call s:hi('typescriptVariable',           s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('typescriptBinaryOp',           s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptAssign',             s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptObjectLabel',        s:blue,    '', '', s:cterm_blue, '')
call s:hi('typescriptDotNotation',        s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptOperator',           s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptTernaryOp',          s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptTypeAnnotation',     s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptIdentifierName',     s:fg,      '', '', s:cterm_fg, '')
call s:hi('typescriptArrowFuncArg',       s:byellow, '', '', s:cterm_byellow, '')
call s:hi('typescriptParamImpl',          s:byellow, '', '', s:cterm_byellow, '')
call s:hi('typescriptRepeat',             s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('typescriptStatementKeyword',   s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('typescriptAliasKeyword',       s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('typescriptInterfaceKeyword',   s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('typescriptTemplateSB',         s:red,     '', '', s:cterm_red, '')
call s:hi('typescriptMemberOptionality',  s:byellow, '', '', s:cterm_byellow, '')
call s:hi('typescriptOptionalMark',       s:byellow, '', '', s:cterm_byellow, '')
call s:hi('typescriptUnaryOp',            s:red,     '', '', s:cterm_red, '')

" gitgutter
call s:hi('GitGutterAdd',          s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('GitGutterChange',       s:blue,    '', '', s:cterm_blue, '')
call s:hi('GitGutterDelete',       s:red,     '', '', s:cterm_red, '')
call s:hi('GitGutterChangeDelete', s:red,     '', '', s:cterm_red, '')

" plug
call s:hi('plug2',              s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('plugH2',             s:cyan,    '', 'bold', s:cterm_cyan, '', 'bold')
call s:hi('plugBracket',        s:blue,    '', '', s:cterm_blue, '')
call s:hi('plugNumber',         s:byellow, '', '', s:cterm_byellow, '')
call s:hi('plugDash',           s:byellow, '', '', s:cterm_byellow, '')
call s:hi('plugStar',           s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('plugMessage',        s:byellow, '', '', s:cterm_byellow, '')
call s:hi('plugName',           s:blue,    '', '', s:cterm_blue, '')
call s:hi('plugUpdate',         s:red,     '', '', s:cterm_red, '')
call s:hi('plugEdge',           s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('plugSha',            s:bgreen,  '', '', s:cterm_bgreen, '')
call s:hi('plugNotLoaded',      s:black,   '', '', s:cterm_black, '')

" signify
hi link SignifySignAdd GitGutterAdd
hi link SignifySignDelete GitGutterDelete
hi link SignifySignDeleteFirstLine SignifySignDelete
hi link SignifySignChange GitGutterChange
hi link SignifySignChangeDelete GitGutterChangeDelete

" stylus
call s:hi('stylusVariable',  s:fg,      '', '', s:cterm_fg, '')
call s:hi('stylusClass',     s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('stylusClassChar', s:blue,    '', '', s:cterm_blue, '')
call s:hi('stylusId',        s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('stylusIdChar',    s:blue,    '', '', s:cterm_blue, '')
call s:hi('cssVisualVal',    s:fg,      '', '', s:cterm_fg, '')
call s:hi('stylusImport',    s:byellow, '', '', s:cterm_byellow, '')

" vim (extended)
call s:hi('vimCommand',      s:bblue,   '', '', s:cterm_bblue, '')
call s:hi('vimVar',          s:fg,      '', '', s:cterm_fg, '')
call s:hi('vimFuncName',     s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('vimIsCommand',    s:fg,      '', '', s:cterm_fg, '')
call s:hi('vimUserFunc',     s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('vimAutoCmd',      s:bblue,   '', '', s:cterm_bblue, '')
call s:hi('vimAutoEvent',    s:byellow, '', '', s:cterm_byellow, '')
call s:hi('vimHiGroup',      s:byellow, '', '', s:cterm_byellow, '')
call s:hi('vimHighlight',    s:magenta, '', '', s:cterm_mag, '')
call s:hi('vimCommentString',s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('vimCommentTitle', s:bblack,  '', '', s:cterm_bblack, '')
call s:hi('vimError',        s:fg,      s:red, '', s:cterm_fg, s:cterm_red)

" xml
call s:hi('htmlTag',            s:punct,   '', '', s:cterm_punct, '')
call s:hi('htmlEndTag',         s:punct,   '', '', s:cterm_punct, '')
call s:hi('htmlTagName',        s:red,     '', '', s:cterm_red, '')
call s:hi('htmlArg',            s:magenta, '', '', s:cterm_mag, '')
call s:hi('xmlTag',             s:punct,   '', '', s:cterm_punct, '')
call s:hi('xmlEndTag',          s:punct,   '', '', s:cterm_punct, '')
call s:hi('xmlTagName',         s:red,     '', '', s:cterm_red, '')
call s:hi('xmlNamespace',       s:byellow, '', '', s:cterm_byellow, '')
call s:hi('xmlAttribPunct',     s:red,     '', '', s:cterm_red, '')
call s:hi('xmlProcessingDelim', s:red,     '', '', s:cterm_red, '')

" python
call s:hi('pythonBuiltin',   s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('pythonSelf',      s:bblue,   '', 'italic', s:cterm_bblue, '', 'italic')
call s:hi('pythonDecorator', s:magenta, '', '', s:cterm_mag, '')

" go
call s:hi('goPackage', s:bblue, '', '', s:cterm_bblue, '')
call s:hi('goImport',  s:bblue, '', '', s:cterm_bblue, '')
call s:hi('goFunc',    s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('goStruct',  s:blue,  '', '', s:cterm_blue, '')

" rust
call s:hi('rustSelf',      s:bblue,   '', 'italic', s:cterm_bblue, '', 'italic')
call s:hi('rustFuncCall',  s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('rustModPath',   s:blue,    '', '', s:cterm_blue, '')
call s:hi('rustAttribute', s:magenta, '', '', s:cterm_mag, '')

" shell
call s:hi('shVariable', s:fg,    '', '', s:cterm_fg, '')
call s:hi('shFunction', s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('shDeref',    s:bcyan, '', '', s:cterm_bcyan, '')

" yaml
call s:hi('yamlFlowString',            s:bgreen, '', '', s:cterm_bgreen, '')
call s:hi('yamlFlowStringDelimiter',   s:fg,     '', '', s:cterm_fg, '')
call s:hi('yamlKeyValueDelimiter',     s:red,    '', '', s:cterm_red, '')
call s:hi('yamlKey',                   s:blue,   '', '', s:cterm_blue, '')

" toml
call s:hi('tomlTable', s:blue, '', '', s:cterm_blue, '')
call s:hi('tomlKey',   s:blue, '', '', s:cterm_blue, '')

" js (extended)
call s:hi('jsFuncCall',        s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('jsFuncArgs',        s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsThis',            s:bblue,   '', 'italic', s:cterm_bblue, '', 'italic')
call s:hi('jsParensIfElse',    s:blue,    '', '', s:cterm_blue, '')
call s:hi('jsObjectKey',       s:blue,    '', '', s:cterm_blue, '')
call s:hi('jsRepeat',          s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('jsArrowFunction',   s:green,   '', '', s:cterm_green, '')
call s:hi('jsFunctionKey',     s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('jsFuncName',        s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('jsObjectFuncName',  s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('jsNull',            s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsObjectColon',     s:red,     '', '', s:cterm_red, '')
call s:hi('jsParens',          s:blue,    '', '', s:cterm_blue, '')
call s:hi('jsFuncParens',      s:blue,    '', '', s:cterm_blue, '')
call s:hi('jsFuncArgs',        s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsSpecial',         s:byellow, '', '', s:cterm_byellow, '')
call s:hi('jsTemplateBraces',  s:red,     '', '', s:cterm_red, '')
call s:hi('jsGlobalObjects',   s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('jsGlobalNodeObjects',s:blue,   '', '', s:cterm_blue, '')
call s:hi('jsImport',          s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('jsExport',          s:cyan,    '', '', s:cterm_cyan, '')
call s:hi('jsExportDefault',   s:yellow,  '', '', s:cterm_yellow, '')
call s:hi('jsExportDefaultGroup',s:cyan,  '', '', s:cterm_cyan, '')
call s:hi('jsFrom',            s:cyan,    '', '', s:cterm_cyan, '')

" typescript (extended braces)
call s:hi('typescriptBraces', s:punct, '', '', s:cterm_punct, '')

" =========================
" terminal (neovim)
" =========================
if has('nvim')
  let g:terminal_color_foreground = s:fg
  let g:terminal_color_background = s:bg
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
