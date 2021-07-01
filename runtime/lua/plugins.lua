vim.cmd([[packadd packer.nvim]])

local packer = require("packer")
packer.startup(function()
	-- pckage
	-- https://github.com/wbthomason/packer.nvim
	use("wbthomason/packer.nvim")

	-- colorscheme & statusline
	use("arcticicestudio/nord-vim")
	-- use("itchyny/lightline.vim")
	use("vim-airline/vim-airline")

	-- git
	use("tpope/vim-fugitive")
	use("rhysd/git-messenger.vim")
	use("airblade/vim-gitgutter")
	use("junegunn/gv.vim")

	-- fuzzy finder
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

			-- local actions = require("telescope.actions")
			-- require("telescope").setup({
			-- 	defaults = {
			-- 		mappings = {
			-- 			i = {
			-- 				["<esc>"] = actions.close,
			-- 			},
			-- 		},
			-- 	},
			-- })
		end,
	})

	-- filer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
		},
	})
	use({
		"scrooloose/nerdtree",
		requires = {
			{ "ryanoasis/vim-devicons", "ryanoasis/nerd-fonts" },
		},
	})

	-- lsp
	-- https://github.com/iamcco/diagnostic-languageserver

	-- treesitter

	-- edit
	use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("jiangmiao/auto-pairs")

	-- formatter
	use("sbdchd/neoformat")

	-- fold
	-- use("arecarn/vim-fold-cycle")

	-- gx
	use("tyru/open-browser.vim")
	-- use("LumaKernel/open-browser.vim")

	--
	-- filetypes
	--
	use("sheerun/vim-polyglot")

	-- markdown
	-- 自動的に遅延読み込みとみなされます。
	use({
		"npxbr/glow.nvim",
		cmd = { "Glow", "GlowInstall" },
		-- run オプションを指定すると、インストール時・更新時に
		-- 実行するコマンドを指定できます。
		run = [[:GlowInstall]],
		-- 先頭に : がついていないなら bash -c '...' で実行されます。
		-- run = [[npm install]],
		-- 関数も指定可能です。
		-- run = function() vim.cmd[[GlowInstall]] end,
	})
end)

vim.cmd([[PackerInstall]])
