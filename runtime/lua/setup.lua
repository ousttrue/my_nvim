-- https://neovim.io/doc/user/lua.html
-- https://github.com/nanotee/nvim-lua-guide
--   https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md
-- https://zenn.dev/slin/articles/2020-11-03-neovim-lua2
-- @param pos int
-- @param path strring
local function insert_path(pos, path)
    path = path:gsub("/", "\\")

    if vim.env.PATH:find(path) then
        return
    end

    if pos == 0 then
        -- head
        if not path:match ";$" then
            path = path + ";"
        end
        vim.env.PATH = path .. vim.env.PATH
    else
        -- tail
        if not vim.env.PATH:match ";$" then
            path = ";" .. path
        end
        vim.env.PATH = vim.env.PATH .. path
    end
end

if vim.env.USERPROFILE then
    insert_path(-1, "C:\\Python38")
    insert_path(-1, "C:\\Python38\\Scripts")
    insert_path(-1, vim.env.USERPROFILE .. "\\.cargo\\bin")
    insert_path(-1, vim.env.USERPROFILE .. "\\go\\bin")
    insert_path(-1, "C:\\Program Files\\LLVM\\bin")
    insert_path(-1, vim.env.APPDATA .. "\\npm")
end

vim.api.nvim_set_keymap("n", "[prefix]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Space>", "[prefix]", {})
vim.api.nvim_set_keymap("n", "[bookmark]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", ",", "[bookmark]", {})
vim.api.nvim_set_keymap("n", "[external]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "'", "[external]", {})

--
-- settings
--
vim.o.ambiwidth = "single"
if vim.env.SHELL then
    -- not windows
    print "SHELL"
else
    if vim.fn.exists "g:GuiName" ~= 0 then
        -- nvim-qt
        print "nvim-qt"
    elseif vim.fn.exists "g:nvy" ~= 0 then
        -- nvy
        print "nvy"
    else
        -- windows cmd.exe
        print "CMD"
        vim.o.ambiwidth = "double"
    end
end

vim.o.termguicolors = true
vim.o.number = true
vim.o.autochdir = true
vim.o.hidden = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.sts = 4
vim.o.expandtab = true
vim.o.inccommand = "split"
vim.o.ic = true
vim.o.clipboard = "unnamed"
-- vim.o.list = true
-- vim.o.listchars = "tab:»-,eol:↲,extends:»,precedes:«,space:."

--
-- terminal
--
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
-- vim.o.shell = "pwsh.exe"
-- vim.o.shellcmdflag = "-NoProfile -NoLogo -NonInteractive -Command"
if vim.fn.has "win32" ~= 0 then
    vim.cmd [[command! -nargs=* T split | wincmd j | resize 20 | terminal pwsh.exe <args>]]
else
    vim.cmd [[command! -nargs=* T split | wincmd j | resize 20 | terminal <args>]]
end
vim.cmd "autocmd TermOpen * startinsert"

--
-- keymaps
--
-- vim.api.nvim_set_keymap( 'n', 'j', 'gj', {noremap = true} )
-- vim.api.nvim_set_keymap("n", "<plus>", ":bn<CR>", {})
-- vim.api.nvim_set_keymap("n", "<minus>", ":bp<CR>", {})
-- paste
vim.cmd "noremap! <S-Insert> <C-R>+"
-- tab
-- vim.api.nvim_set_keymap("", "<C-l>", ":tabn<CR>", {})
-- vim.api.nvim_set_keymap("", "<C-h>", ":tabp<CR>", {})
-- vim.api.nvim_set_keymap("", "<Space>n", ":tabnew<CR>", {})
vim.cmd [[nmap <C-n> :lnext<CR>]]
vim.cmd [[nmap <C-p> :lprevious<CR>]]

vim.api.nvim_set_keymap("n", "<C-l>", ":nohlsearch<CR><C-l>", { noremap = true })
vim.api.nvim_set_keymap("n", "q", ":lua require'close_keep_window'.close()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "Q", ":close<CR>", { noremap = true })

vim.api.nvim_set_var("terminal_ansi_colors", {
    "#073642", -- black
    "#dc322f", -- Red
    "#859900", -- green
    "#b58900", -- yellow
    "#268bd2", -- blue
    "#d33682", -- magenta
    "#2aa198", -- cyan
    "#eee8d5", -- white
    "#002b36", -- black (bright)
    "#cb4b16", -- red (bright)
    "#586e75", -- green (bright)
    "#657b83", -- yellow (bright)
    "#839496", -- blue (bright)
    "#6c71c4", -- magenta (bright)
    "#93a1a1", -- cyan (bright)
    "#fdf6e3", -- white (bright)
})
