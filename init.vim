" this is generated. entry point

lua << EOF
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  -- fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  fn.system({'git', 'clone', 'https://github.com/ousttrue/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
EOF

let g:my_nvim_root = "${my_nvim_root}"
set runtimepath^=${my_nvim_root}/runtime
source ${my_nvim_root}/runtime/entry.vim
