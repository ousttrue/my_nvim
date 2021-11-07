# nvim built-in

`neovim-0.5` から組み込みの LSP-Client 機能が実装される。

<https://neovim.io/doc/user/lsp.html>

各言語ごとの LanguageServer の自動起動などを担うのが lspconfig。

<https://github.com/neovim/nvim-lspconfig>

* go-to-definition
* find-references
* hover
* completion
* rename
* format
* refactor

## :LspInfo

status 確認

## lspconfig

<https://github.com/neovim/nvim-lspconfig>

### packer による install

```lua
packer.startup(function()
    use {
        "neovim/nvim-lspconfig",
        config = function()
            vim.api.nvim_set_var("lsp_signs_enabled", 1)
            vim.api.nvim_set_var("lsp_diagnostics_enabled", 1)
            vim.api.nvim_set_var("lsp_diagnostics_echo_cursor", 1)
            vim.api.nvim_set_var("lsp_virtual_text_enabled", 1)
            -- vim.api.nvim_set_var("lsp_signs_error", { text = "✗" })
            -- vim.api.nvim_set_var("lsp_signs_warning", { text = "‼" })
            -- vim.api.nvim_set_var("lsp_signs_information", { text = "i" })
            -- vim.api.nvim_set_var("lsp_signs_hint", { text = "?" })
        end,
    }
end)
vim.cmd "PackerInstall"
```

## 言語毎の LanguageServer

### python

```
$ npm i -g pyright
```

