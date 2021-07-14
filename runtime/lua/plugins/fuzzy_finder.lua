local M = {}

local use = require("packer").use
-- local use_rocks = require'packer'.use_locks

function M.startup()
	-- https://github.com/nvim-telescope/telescope.nvim
	-- https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
			-- { "nvim-telescope/telescope-ghq.nvim" },
			{ "ousttrue/telescope-ghq.nvim" },
		},
		config = function()
			require("telescope").load_extension("ghq")

			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = { mappings = { i = { ["<esc>"] = actions.close } } },
			})
			-- vim.api.nvim_set_keymap("n", "<Space><Space>", ":<C-u>Telescope git_files<CR>", {})
			vim.api.nvim_set_keymap("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
		end,
	})
	use({
		"junegunn/fzf.vim",
		requires = {
			{
				"junegunn/fzf",
				run = function()
					vim.fn["fzf#install"]()
				end,
			},
		},
		config = function()
			vim.api.nvim_set_keymap("n", "<Space><Space>", ":<C-u>FZF<CR>", {})

			vim.api.nvim_set_var("fzf_layout", { window = 'lua require("floatingFZF")()' })
		end,
	})
	-- 	"liuchengxu/vim-clap",
	-- 	run = function()
	-- 		-- " Build the extra binary if cargo exists on your system.
	-- 		vim.cmd([[Clap install-binary]])
	-- 	end,
	-- 	config = function()
	-- 		vim.api.nvim_set_keymap("n", "<Space><Space>", ":<C-u>Clap git_files<CR>", {})

	-- 		-- " For example, use <C-n>/<C-p> instead of <C-j>/<C-k> to navigate the result.
	-- 		vim.cmd(
	-- 			[[autocmd FileType clap_input inoremap <silent> <buffer> <C-n> <C-R>=clap#navigation#linewise('down')<CR>]]
	-- 		)
	-- 		vim.cmd(
	-- 			[[autocmd FileType clap_input inoremap <silent> <buffer> <C-p> <C-R>=clap#navigation#linewise('up')<CR>]]
	-- 		)
	-- 		vim.cmd([[autocmd FileType clap_input call compe#setup({ 'enabled': v:false }, 0)]])
	-- 	end,
	-- })
	-- use({
	-- 	"Yggdroot/LeaderF",
	-- 	run = function()
	-- 		vim.cmd([[LeaderfInstallCExtension]])
	-- 	end,
	-- 	config = function()
	-- 		vim.api.nvim_set_var('Lf_WindowPosition', 'popup')
	-- 		vim.api.nvim_set_var('Lf_PopupHeight', 0.7)
	-- 		vim.api.nvim_set_keymap("n", "<Space><Space>", ":<C-u>Leaderf<CR>", {})
	-- 	end,
	-- })
	-- https://github.com/Shougo/denite.nvim
	-- use({
	-- 	"Shougo/denite.nvim",
	-- 	requires = {
	-- 		{ "Jagua/vim-denite-ghq" },
	-- 	},
	-- 	run = function()
	-- 		vim.cmd([[UpdateRemotePlugins]])
	-- 	end,
	-- 	config = function()
	-- 		require("plugins_denite").config()
	-- 	end,
	-- })
end

return M
