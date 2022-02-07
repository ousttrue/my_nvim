if has('win32')
    let g:python3_host_prog = "C:\\Python38\\python.exe"
    let $INCLUDE = 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Tools\\MSVC\\14.27.29110\\ATLMFC\\include;C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Tools\\MSVC\\14.27.29110\\include;C:\\Program Files (x86)\\Windows Kits\\NETFXSDK\\4.7.1\\include\\um;C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.18362.0\\ucrt;C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.18362.0\\shared;C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.18362.0\\um;C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.18362.0\\winrt;C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.18362.0\\cppwinrt'
    let $LIB = 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Tools\\MSVC\\14.27.29110\\ATLMFC\\lib\\x64;C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Tools\\MSVC\\14.27.29110\\lib\\x64;C:\\Program Files (x86)\\Windows Kits\\NETFXSDK\\4.7.1\\lib\\um\\x64;C:\\Program Files (x86)\\Windows Kits\\10\\lib\\10.0.18362.0\\ucrt\\x64;C:\\Program Files (x86)\\Windows Kits\\10\\lib\\10.0.18362.0\\um\\x64'
else
    let g:python3_host_prog = "/usr/bin/python3"
endif

if exists("g:nvy")
    set guifont=Cica:h14
endif

au BufNewFile,BufRead .xonshrc setf python

let mapleader=" "
nnoremap <Space> <Nop>
" lua require 'plugins'
lua require 'noplugins'
lua require 'setup'
lua require 'lang.lua'
lua require 'lang.python'
lua require 'lang.cpp'
" lua require 'lang.rust'
" lua require 'lang.cs'
