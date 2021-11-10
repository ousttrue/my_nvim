--
-- https://oroques.dev/notes/neovim-init/
--
local packer = require "packer"
require("packer.luarocks").install_commands()
-- require('packer.luarocks').setup_paths()
-- require('luarocks.loader')

packer.startup(function()
    -- https://github.com/wbthomason/packer.nvim
    use "nvim-lua/plenary.nvim"
    use "wbthomason/packer.nvim"

    -- package
    require "plugins.use_core"(use)
    require "plugins.use_treesitter"(use)
    require "plugins.use_lsp"(use)
    require "plugins.use_dap"(use)
    require "plugins.use_skk"(use)

    use "neoclide/jsonc.vim"
end)

vim.cmd "PackerInstall"

