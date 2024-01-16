# create

- [x] @2023 [Vimカラースキーム自作のすすめ | Eureka Engineering](https://medium.com/eureka-engineering/recommend-generating-own-colorsheme-3114abe3e1d)
- [ ] @2019 [vimのカラースキームの設定・編集方法（初心者〜上級者） #Vim - Qiita](https://qiita.com/sff1019/items/3f73856b78d7fa2731c7)

## lua

- [x] @2022 [お手軽カラースキーム制作 - Qiita](https://qiita.com/slin/items/be6dddbdb49a790692ba)

```lua
-- 定義開始
vim.o.background = "dark" -- or "light"
vim.g.colors_name = "THEME_NAME"
vim.cmd("hi clear")
vim.cmd[[colorscheme THEME_NAME]]

-- definitions...
vim.api.nvim_set_hl(0, "@repeat.lua", { force=true, fg = color.keyword })
vim.api.nvim_set_hl(0, "your-group", { force=true, link = "another-group" })
```

すべてクリアする例

```lua
  vim.api.nvim_set_hl(0, "Normal", { force = true, fg = "#FFFFFF", bg = "#000000" })
  vim.api.nvim_set_hl(0, "NormalNC", { force = true, fg = "#FFFFFF", bg = "#444444" })
  vim.api.nvim_set_hl(0, "Unknown", { force = true, fg = "#FF00FF" })

  vim.api.nvim_set_hl(0, "SpecialKey", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "TermCursor", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "NonText", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Directory", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "ErrorMsg", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Search", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "CurSearch", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "MoreMsg", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "ModeMsg", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "LineNr", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Question", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "StatusLine", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Title", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Visual", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "WarningMsg", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Folded", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiffAdd", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiffChange", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiffDelete", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiffText", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "SignColumn", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Conceal", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "SpellBad", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "SpellCap", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "SpellRare", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "SpellLocal", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Pmenu", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "PmenuSel", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "PmenuThumb", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "TabLineSel", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "CursorColumn", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "CursorLine", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "ColorColumn", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "QuickFixLine", { link = "Unknown" })

  vim.api.nvim_set_hl(0, "NormalFloat", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Cursor", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "RedrawDebugNormal", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Todo", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Underlined", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "lCursor", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Normal", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Statement", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Special", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticError", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticOk", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Comment", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Identifier", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "String", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Function", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "FloatShadow", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "FloatShadowThrough", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "MatchParen", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "RedrawDebugClear", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "RedrawDebugComposed", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "RedrawDebugRecompose", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "Error", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { link = "Unknown" })
  vim.api.nvim_set_hl(0, "NvimInternalError", { link = "Unknown" })

```

## ファイル配置

`~/.config/nvim/colors/hoge.lua`

## service

### vim

- [ThemeCreator](http://mswift42.github.io/themecreator/#)

## helper

### colortemplate

[GitHub - lifepillar/vim-colortemplate: The Toolkit for Vim Color Scheme Designers!](https://github.com/lifepillar/vim-colortemplate)

### colorbuddy

https://github.com/tjdevries/colorbuddy.nvim

### lush

- [GitHub - rktjmp/lush.nvim: Create Neovim themes with real-time feedback, export anywhere.](https://github.com/rktjmp/lush.nvim)

### base16

- [Base16 Gallery](https://tinted-theming.github.io/base16-gallery/)
- @2022 [俺自身がNeovim base16 colorschemeになることだ](https://zenn.dev/kawarimidoll/articles/8e58296f5b8118)
