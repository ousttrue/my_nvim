# my_nvim

## Dependencies

### Windows10(64bit)

* VC2019
* CMake, ninja
* `C:/Python38`
* rustup
* go, ghq
* LLVM(treesitter, cland)
* nodejs 14(pyright)

### Ubuntu-20.04(WSL2)

* gcc
* cmake, ninja
* `/usr/bin/python3`
* rustup
* go, ghq
* nodejs 14(pyright)

## tasks.py

```
$ pip install invoke
```

```
❯ invoke -l
Available tasks:

  clean          clean ./neovim/build, ./neovim/.deps, ./install
  hererocks      copy lualocks from ./neovim/.deps
  init-files     install neovim init.vim & ginti.vim
  install        install neovim to ./install
  ls             setup language servers
  neovim-build   build ./neovim/build
  neovim-deps    build ./neovim/.deps third-party dependencies
  update         git pull
```

## Languages(lsp & dap)

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

