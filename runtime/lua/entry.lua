-- vim.cmd[[execute("PackerCompile")]]
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
require 'plugins'
vim.cmd[[autocmd BufWritePost setup.lua PackerCompile]]
require 'setup'

