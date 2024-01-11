各言語ごとの LanguageServer の自動起動などを担うのが lspconfig。

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


```{toctree}
nvim-lsp
```

* [x] Lua: LanguageServer([sumneko_lua](https://github.com/sumneko/lua-language-server))
* [x] Python: LanguageServer([pylsp](https://github.com/python-lsp/python-lsp-server))
* [x] Python: LanguageServer([pyright](https://github.com/Microsoft/pyright))
* [x] Python: DebugAdatper([debugpy](https://github.com/microsoft/debugpy))
* [x] C++: LanguageServer(clangd)
* [x] C++: DebugAdapter([codelldb](https://github.com/vadimcn/vscode-lldb))
* [x] Rust: LanguageServer([rust_analyzer](https://github.com/rust-analyzer/rust-analyzer))
* [x] C#: LanguageServer([OmniSharp](https://github.com/omnisharp/omnisharp-roslyn))
* [x] C#: DebugAdapter([netcoredbg](https://github.com/Samsung/netcoredbg))
* [ ] Unity: DebugAdapter([unitydebug](https://github.com/Unity-Technologies/vscode-unity-debug))


