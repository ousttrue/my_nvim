# neovim の ビルドと設定管理

## Windows workaround

[CMakeLists.txt](./neovim/CMakeLists.txt)

```
if(MSVC)
  # XXX: /W4 gives too many warnings. #3241
  add_compile_options(/W3 /source-charset:utf-8 /wd4244 /wd4267 /wd4996 /wd4566)
```

```
> chcp65001
```
