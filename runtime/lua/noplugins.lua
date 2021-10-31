--
-- https://oroques.dev/notes/neovim-init/
--
local packer = require "packer"
require("packer.luarocks").install_commands()
-- require('packer.luarocks').setup_paths()
-- require('luarocks.loader')

packer.startup(function()
    -- pckage
    -- https://github.com/wbthomason/packer.nvim
    use "nvim-lua/plenary.nvim"
    use("wbthomason/packer.nvim")
    -- use "ousttrue/packer.nvim"

    use "tpope/vim-fugitive"
end)

vim.cmd "PackerInstall"
