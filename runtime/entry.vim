if has('win32')
    let g:python3_host_prog = "C:\\Python38\\python.exe"
else
    let g:python3_host_prog = "/usr/bin/python3"
endif

autocmd BufWritePost plugins.lua PackerCompile
lua require 'plugins'
autocmd BufWritePost setup.lua PackerCompile
lua require 'setup'
