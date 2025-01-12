# highlight-group

```vim
" Background colors for active vs inactive windows
hi ActiveWindow guibg=#17252c
hi InactiveWindow guibg=#0D1B22
```

```lua
-- link
vim.api.nvim_set_hl(0, "MatchParen", { link = "Title" })

-- new
vim.api.nvim_set_hl(0, "NonText", { fg = "#444444" })
```

## name

```vim
:h group-name
```

```
minor group => link +
  |                 v
  + ============> preferred group(11)
```

- case insensitive

`[a-zA-Z0-9_.@-]`

### preferred group(syntax)

- https://neovim.io/doc/user/syntax.html#highlight-default

- Comment
- Constant
- Identifier
- Statement
- PreProc
- Type
- Special
- Underlined
- Ignore
- Error
- Todo

### パターンマッチ

### ExtMark

- [【Neovim】好きな位置にテキストを埋め込んだりハイライトできる「ExtMark」の使い方 - ハイパーマッスルエンジニア](https://www.rasukarusan.com/entry/2021/08/22/202248)

#### verbose

["TODO:" を目立たせたいと思った、どのファイルでも - ばかもりだし](https://baqamore.hatenablog.com/entry/2016/11/15/220358)

### tree-sitter

tree-sitter を主にしてよさそう。

### lsp の semantic token

- [LSP: semantic tokens support by jdrouhard · Pull Request #21100 · neovim/neovim · GitHub](https://github.com/neovim/neovim/pull/21100)

- [lsp-vimでエラーハイライトの見た目を変える方法 - ヘンゼルのパンくず](https://tmls.hatenablog.com/entry/2021/02/21/050729)
- [Neovim LSPでカーソル下の変数をハイライトする機能](https://zenn.dev/botamotch/scraps/62eda54e7fba90)

## userinterface

UI部品や、marker など。
git, column, conceal... etc

- text
- bg
- statusbar
- winbar
- tabbar
- filer
- border
- scrollbar
- popup
- floating

### lsp

```vim
:h diagnostic-highlights
:h lsp-highlight
:h expr-highlight
```

### focus

```
NormalNC
StatusLineNC
WinBarNC
```

### plugin highlight-groups

plugin の定義するカスタムグループ

https://github.com/EdenEast/nightfox.nvim?tab=readme-ov-file#supported-plugins

### example

```
Highlighting groups for various occasions
-----------------------------------------
SpecialKey	SpecialKey
TermCursor	TermCursor
NonText	NonText EndOfBuffer Whitespace LspInlayHint
Directory	Directory
ErrorMsg	ErrorMsg NvimInvalidSpacing
Search	Search Substitute
CurSearch	CurSearch IncSearch
MoreMsg	MoreMsg
ModeMsg	ModeMsg
LineNr	LineNr LineNrAbove LineNrBelow
CursorLineNr	CursorLineNr
Question	Question
StatusLine	StatusLine TabLine TabLineFill MsgSeparator WinBar
StatusLineNC	StatusLineNC WinBarNC
Title	Title FloatTitle FloatFooter
Visual	Visual VisualNOS SnippetTabstop
WarningMsg	WarningMsg
Folded	Folded
DiffAdd	DiffAdd
DiffChange	DiffChange
DiffDelete	DiffDelete
DiffText	DiffText
SignColumn	SignColumn CursorLineSign FoldColumn CursorLineFold
Conceal	Conceal
SpellBad	SpellBad
SpellCap	SpellCap
SpellRare	SpellRare
SpellLocal	SpellLocal
Pmenu	Pmenu PmenuKind PmenuExtra PmenuSbar
PmenuSel	PmenuSel WildMenu PmenuKindSel PmenuExtraSel
PmenuThumb	PmenuThumb
TabLineSel	TabLineSel
CursorColumn	CursorColumn
CursorLine	CursorLine
ColorColumn	ColorColumn
QuickFixLine	QuickFixLine

Syntax highlighting groups
--------------------------
NormalFloat	NormalFloat FloatBorder
Cursor	Cursor CursorIM
RedrawDebugNormal	RedrawDebugNormal
Todo	Todo
Underlined	Underlined
lCursor	lCursor
Normal	Normal WinSeparator VertSplit Ignore NvimSpacing
Statement	Statement Conditional Repeat Label Keyword Exception Conditional Repeat Label Keyword Exception
Special	Special Tag SpecialChar SpecialComment Debug Debug Tag
DiagnosticError	DiagnosticError DiagnosticFloatingError DiagnosticVirtualTextError DiagnosticSignError
DiagnosticWarn	DiagnosticWarn DiagnosticFloatingWarn DiagnosticVirtualTextWarn DiagnosticSignWarn
DiagnosticInfo	DiagnosticInfo DiagnosticFloatingInfo DiagnosticVirtualTextInfo DiagnosticSignInfo
DiagnosticHint	DiagnosticHint DiagnosticFloatingHint DiagnosticVirtualTextHint DiagnosticSignHint
DiagnosticOk	DiagnosticOk DiagnosticFloatingOk DiagnosticVirtualTextOk DiagnosticSignOk
Comment	Comment DiagnosticUnnecessary Comment
Identifier	Identifier NvimIdentifier NvimIdentifierScope NvimIdentifierScopeDelimiter NvimIdentifierName
	NvimIdentifierKey NvimOptionName NvimOptionScope NvimOptionScopeDelimiter NvimEnvironmentName
String	String String SpecialChar SpecialChar NvimRegister NvimString NvimStringBody NvimStringQuote
	NvimStringSpecial NvimSingleQuote NvimSingleQuotedBody NvimSingleQuotedQuote NvimDoubleQuote
	NvimDoubleQuotedBody NvimDoubleQuotedEscape NvimInvalidStringBody NvimInvalidStringSpecial
	NvimInvalidSingleQuotedBody NvimInvalidSingleQuotedQuote NvimInvalidDoubleQuotedBody
	NvimInvalidDoubleQuotedEscape
Function	Function Function Special Macro
FloatShadow	FloatShadow
FloatShadowThrough	FloatShadowThrough
MatchParen	MatchParen
RedrawDebugClear	RedrawDebugClear
RedrawDebugComposed	RedrawDebugComposed
RedrawDebugRecompose	RedrawDebugRecompose
Error	Error NvimInvalid NvimInvalidAssignment NvimInvalidPlainAssignment NvimInvalidAugmentedAssignment
	NvimInvalidAssignmentWithAddition NvimInvalidAssignmentWithSubtraction
	NvimInvalidAssignmentWithConcatenation NvimInvalidOperator NvimInvalidUnaryOperator
	NvimInvalidUnaryPlus NvimInvalidUnaryMinus NvimInvalidNot NvimInvalidBinaryOperator
	NvimInvalidComparison NvimInvalidComparisonModifier NvimInvalidBinaryPlus NvimInvalidBinaryMinus
	NvimInvalidConcat NvimInvalidConcatOrSubscript NvimInvalidOr NvimInvalidAnd NvimInvalidMultiplication
	NvimInvalidDivision NvimInvalidMod NvimInvalidTernary NvimInvalidTernaryColon NvimInvalidDelimiter
	NvimInvalidParenthesis NvimInvalidLambda NvimInvalidNestingParenthesis NvimInvalidCallingParenthesis
	NvimInvalidSubscript NvimInvalidSubscriptBracket NvimInvalidSubscriptColon NvimInvalidCurly
	NvimInvalidContainer NvimInvalidDict NvimInvalidList NvimInvalidValue NvimInvalidIdentifier
	NvimInvalidIdentifierScope NvimInvalidIdentifierScopeDelimiter NvimInvalidIdentifierName
	NvimInvalidIdentifierKey NvimInvalidColon NvimInvalidComma NvimInvalidArrow NvimInvalidRegister
	NvimInvalidNumber NvimInvalidFloat NvimInvalidNumberPrefix NvimInvalidOptionSigil
	NvimInvalidOptionName NvimInvalidOptionScope NvimInvalidOptionScopeDelimiter
	NvimInvalidEnvironmentSigil NvimInvalidEnvironmentName NvimInvalidString NvimInvalidStringQuote
	NvimInvalidSingleQuote NvimInvalidDoubleQuote NvimInvalidDoubleQuotedUnknownEscape
	NvimInvalidFigureBrace NvimDoubleQuotedUnknownEscape
DiagnosticUnderlineError	DiagnosticUnderlineError
DiagnosticUnderlineWarn	DiagnosticUnderlineWarn
DiagnosticUnderlineInfo	DiagnosticUnderlineInfo
DiagnosticUnderlineHint	DiagnosticUnderlineHint
DiagnosticUnderlineOk	DiagnosticUnderlineOk
DiagnosticDeprecated	DiagnosticDeprecated
NvimInternalError	NvimInternalError NvimFigureBrace NvimSingleQuotedUnknownEscape NvimInvalidSingleQuotedUnknownEscape
```
