# neovim の ビルドと設定管理

## Required

### Windows10(64bit)

* `C:/Python38`
* VC2019
* CMake

### Ubuntu-20.04(WSL2)

## build

* `build.py` で `install/bin` に nvim をビルドしてインストールする

## TODO

* [x] Lua: LanguageServer(sumneko_lua)
* [x] Python: LanguageServer(pylsp)
* [x] Python: DebugAdatper(debugpy)
* [x] C++: LanguageServer(clangd)
* [x] C++: DebugAdapter(codelldb)
* [x] Rust: LanguageServer(rust_analyzer)
* [ ] C#: LanguageServer
* [ ] C#: DebugAdapter
* [ ] Unity: DebugAdapter
