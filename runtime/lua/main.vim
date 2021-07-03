execute PackerCompile
autocmd BufWritePost plugins.lua,setup.lua PackerCompile
lua require 'plugins'
lua require 'setup'

