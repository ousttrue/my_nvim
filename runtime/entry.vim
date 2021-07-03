if has('win32')
    let g:python3_host_prog = "C:\\Python38\\python.exe"
else
    let g:python3_host_prog = "/usr/bin/python3"
endif

autocmd BufWritePost plugins.lua PackerCompile
lua require 'plugins'
autocmd BufWritePost setup.lua PackerCompile
lua require 'setup'

autocmd BufWritePost setup_lua.lua PackerCompile
lua require 'setup_lua'
autocmd BufWritePost setup_python.lua PackerCompile
lua require 'setup_python'
