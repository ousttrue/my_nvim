# python

## LanguageServer

* https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
* [NeovimでモダンなPython環境を構築するv2(LSPを添えて)](https://qiita.com/lighttiger2505/items/3065164798bc9cd615d4)

`pylsp` を選択した。型対応があって `pyright` が強そうなのだけど。

* https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pylsp

```lua
require'lspconfig'.pylsp.setup{}
```

* python3 で動く
* pyls は python2 仕様の print 文があって python3 では動かない

* completion
* formatter

## DebugAdapter

`$ pip install debugpy`

```lua
local dap = require("dap")
dap.adapters.python = {
    type = "executable",
    command = "C:/Python38/python.exe",
    args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return "C:/Python38/python.exe"
        end,
    },
}
```

