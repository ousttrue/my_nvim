# neovim build and configuration

## Dependencies

### Windows10(64bit)

* VC2019
* CMake
* `C:/Python38`
* rustup
* go, ghq
* LLVM(treesitter, cland)

### Ubuntu-20.04(WSL2)

## build

* `build.py` で `install/bin` に nvim をビルドしてインストールする

## Languages(lsp & dap)

* [x] Lua: LanguageServer([sumneko_lua](https://github.com/sumneko/lua-language-server))
* [x] Python: LanguageServer([pylsp](https://github.com/python-lsp/python-lsp-server))
* [x] Python: DebugAdatper([debugpy](https://github.com/microsoft/debugpy))
* [x] C++: LanguageServer(clangd)
* [x] C++: DebugAdapter([codelldb](https://github.com/vadimcn/vscode-lldb))
* [x] Rust: LanguageServer([rust_analyzer](https://github.com/rust-analyzer/rust-analyzer))
* [x] C#: LanguageServer([OmniSharp](https://github.com/omnisharp/omnisharp-roslyn))
* [x] C#: DebugAdapter([netcoredbg](https://github.com/Samsung/netcoredbg))
* [ ] Unity: DebugAdapter([unitydebug](https://github.com/Unity-Technologies/vscode-unity-debug))

