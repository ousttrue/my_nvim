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

    -- pckage
    require "plugins.use_core"(use)
end)

vim.cmd "PackerInstall"
