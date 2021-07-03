autocmd BufWritePost plugins.lua PackerCompile
lua require 'plugins'
autocmd BufWritePost setup.lua PackerCompile
lua require 'setup'
