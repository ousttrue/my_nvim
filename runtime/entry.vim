if has('win32')
    let g:python3_host_prog = "C:\\Python38\\python.exe"
else
    let g:python3_host_prog = "/usr/bin/python3"
endif

lua require 'plugins'
lua require 'setup'
lua require 'setup_lua'
lua require 'setup_python'
lua require 'setup_cpp'
lua require 'setup_rust'
lua require 'setup_cs'

