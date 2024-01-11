# comment

::: warning `<c-/>` `<c-_>` 両方設定する
term では `<C-_>` など代替コードが来る。
gui では `<C-/>` が来る。

- @2014 [\[vim\] Ctrl + / (スラッシュ) キーをマップする #Vim - Qiita](https://qiita.com/castaneai/items/42e917d1fdf6d83b717c)

:::

::: tip ほぼ行コメントしか使わない
:::

::: tip tree-sitter が使えるのでは？
:::

https://github.com/numToStr/Comment.nvim

```lua
{
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup {
      mappings = { basic = false, extra = false },
    }

    local api = require "Comment.api"
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

    -- Toggle current line (linewise) using C-/
    -- vim.keymap.set("n", "<C-_>", api.toggle.linewise.current)
    -- vim.keymap.set("n", "<C-/>", api.toggle.linewise.current)

    -- Toggle selection (linewise)

    function vcomment()
      vim.api.nvim_feedkeys(esc, "nx", false)
      api.toggle.linewise(vim.fn.visualmode())
    end

    vim.keymap.set("x", "<C-_>", vcomment)
    vim.keymap.set("x", "<C-/>", vcomment)

    local ft = require "Comment.ft"
    ft.vala = { "//%s", "/*%s*/" }
  end,
},
```
