# packer

* <https://github.com/wbthomason/packer.nvim>

## install

## luarocks

packer で `use_rocks` もしくは `rocks` を記述すると、 `hererocks` によるがインストールされる。

```lua
use_rocks "penlight"

-- もしくは
use { 
	"some",
	rocks = {
		{"penlight"},
	}
}
```

場所は、 `nvim.fn.stdpath "cache"` 下。

* `~/.cache/nvim/hererocks`
* `%USERPROFILE%/AppData/Local/temp/nvim/hererocks`

で Windows では hererocks が失敗するということが分かった。
Linux 版の hererocks の構成は以下の通り。
```
~/.cache/nvim/hererocks
├── 2.1.0-beta3
│   ├── bin
│   │   ├── activate
│   │   ├── activate.csh
│   │   ├── activate.fish
│   │   ├── activate_posix
│   │   ├── get_deactivated_path.lua
│   │   ├── lua
│   │   ├── luarocks
│   │   └── luarocks-admin
│   ├── etc
│   │   └── luarocks
│   ├── hererocks.manifest
│   ├── include
│   │   ├── lauxlib.h
│   │   ├── lua.h
│   │   ├── lua.hpp
│   │   ├── luaconf.h
│   │   ├── luajit.h
│   │   └── lualib.h
│   ├── lib
│   │   ├── libluajit-5.1.a
│   │   ├── libluajit-5.1.so.2
│   │   ├── lua
│   │   └── luarocks
│   └── share
│       └── lua
└── hererocks.py
```

`%USERPROFILE%/Local/nvim-data/site/pack/packer/start/packer.nvim/lua/pcker/luarocks.lua` が Windows 動くように改造

```lua
local function activate_hererocks_cmd(install_path)
  local activate_file = 'activate'
  local user_shell = os.getenv 'SHELL'
  local shell = user_shell:gmatch '([^/]*)$'()
  if shell == 'fish' then
    activate_file = 'activate.fish'
  elseif shell == 'csh' then
    activate_file = 'activate.csh'
  end

  return fmt('source %s', util.join_paths(install_path, 'bin', activate_file))
end

local function hererocks_cmd(install_path, args)
  if vim.fn.has('win32') ~= 0 then
	-- これで %USERPROFILE%/AppData/Local/temp/nvim/hererocks/2.1.0-beta3/luarocks.bat を呼び出す
    return {
      os.getenv 'COMSPEC',
      '/C',
      fmt('luarocks --tree=%s %s', shell_hererocks_dir, args),
    }
  else
    return {
      os.getenv 'SHELL',
      '-c',
      fmt('%s && luarocks --tree=%s %s', activate_hererocks_cmd(install_path), shell_hererocks_dir, args),
    }
  end
end

local function run_luarocks(args, disp, operation_name)
  local cmd =hererocks_cmd(hererocks_install_dir, args)
 ```

`%USERPROFILE%/AppData/Local/temp/nvim/hererocks` に luarocks を展開する。
`neovim` のビルドに使った luarocks をコピーする。

* `.deps/usr/luarocks`
* `.dpes/usr/lib/luarocks`

TODO: パスを調整する

`:lua require('packer.luarocks').setup_paths()`

