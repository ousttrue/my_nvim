Windows の runtime。

# nivm.exe

https://github.com/neovim/neovim/releases から `msi` をダウンロードしてインストール。

## GUI: nvy

nvy は D3D 製のGUIです。

https://github.com/RMichelsen/Nvy/releases

から `nvy.exe` をダウンロードして、`nvim.exe` と同じフォルダに配置。

### nerdfont

https://github.com/yuru7/HackGen/releases

から HackGen Console NF

```lua
  if vim.g.nvy then
    vim.o.guifont = "HackGen Console NF:h13"
  end
```

