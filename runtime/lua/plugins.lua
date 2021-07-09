--
-- https://oroques.dev/notes/neovim-init/
--
local packer = require("packer")
require("packer.luarocks").install_commands()
-- require('packer.luarocks').setup_paths()
-- require('luarocks.loader')

packer.startup(function()
	-- pckage
	-- https://github.com/wbthomason/packer.nvim
	-- use("wbthomason/packer.nvim")
	use("ousttrue/packer.nvim")

	use_rocks("penlight")
	use({ "teal-language/vim-teal", rocks = { { "tl" } } })

	use_rocks({
		"lua-lsp",
		server = "http://luarocks.org/dev",
	})

	use("jremmen/vim-ripgrep")

	-- colorscheme
	-- use("arcticicestudio/nord-vim")
	use({
		"sainnhe/edge",
		config = function()
			vim.api.nvim_set_var("edge_style", "aura")
			vim.cmd([[colorscheme edge]])
		end,
	})
	use({
		"rockerBOO/boo-colorscheme-nvim",
		-- config = function()
		-- 	vim.cmd([[colorscheme boo]])
		-- end,
	})
	use({
		"vigoux/oak",
		-- config = function()
		-- 	vim.cmd([[colorscheme oak]])
		-- end,
	})

	-- statusline
	-- use("itchyny/lightline.vim")
	use("vim-airline/vim-airline")
	-- use("glepnir/galaxyline.nvim")

	-- ToDo
	-- liuchengxu/vim-which-key

	use("kizza/actionmenu.nvim")
	use("simeji/winresizer")

	use("thinca/vim-quickrun")

	use({
		"skywind3000/asynctasks.vim",
		requires = { { "skywind3000/asyncrun.vim" } },
		config = function()
			vim.api.nvim_set_var("asyncrun_open", 6)
		end,
	})

	-- treesitter
	-- https://github.com/nvim-treesitter/nvim-treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			vim.cmd("TSUpdate")
			vim.cmd("TSInstall python")
			vim.cmd("TSInstall rust")
			vim.cmd("TSInstall lua")
			vim.cmd("TSInstall cpp")
			vim.cmd("TSInstall csharp")
			vim.cmd("TSInstall json")
			vim.cmd("TSInstall go")
		end,
		config = function()
			local ts = require("nvim-treesitter.configs")
			ts.setup({ highlight = { enable = true } })
		end,
	})
	use("nvim-treesitter/playground")
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			vim.g.symbols_outline = {
				highlight_hovered_item = true,
				show_guides = false,
				auto_preview = false,
				position = "left",
				show_numbers = false,
				show_relative_numbers = false,
				show_symbol_details = true,
				keymaps = {
					close = "<Esc>",
					goto_location = "<Cr>",
					focus_location = "o",
					hover_symbol = "<C-space>",
					rename_symbol = "r",
					code_actions = "a",
				},
				lsp_blacklist = {},
			}
		end,
	})
	use({ "liuchengxu/vista.vim", config = function() end })

	-- git
	use("tpope/vim-fugitive")
	use("rhysd/git-messenger.vim")
	use("airblade/vim-gitgutter")
	use("junegunn/gv.vim")
	-- use({
	-- 	"pwntester/octo.nvim",
	-- 	requires = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 	},
	-- 	config = function()
	-- 		require("octo").setup()
	-- 	end,
	-- })
	use("sodapopcan/vim-twiggy")
	use("gregsexton/gitv")

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

			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = { mappings = { i = { ["<esc>"] = actions.close } } },
			})
			vim.api.nvim_set_keymap("n", "<Space><Space>", ":<C-u>Telescope git_files<CR>", {})
			vim.api.nvim_set_keymap("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
		end,
	})
	-- use({
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

	-- filer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			vim.api.nvim_set_keymap("n", "[prefix]tt", ":NvimTreeToggle<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "[prefix]tr", ":NvimTreeRefresh<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "[prefix]tn", ":NvimTreeFindFile<CR>", { noremap = true })
		end,
	})
	-- https://github.com/Xuyuanp/yanil
	use({
		"scrooloose/nerdtree",
		requires = {
			{
				"ryanoasis/vim-devicons", -- "ryanoasis/nerd-fonts",
				"Xuyuanp/nerdtree-git-plugin",
			},
		},
		config = function()
			vim.api.nvim_set_var("NERDTreeGitStatusUseNerdFonts", 1)
			vim.api.nvim_set_var("NERDTreeBookmarksFile", 1)
			vim.api.nvim_set_keymap("n", ",,", ":NERDTreeVCS<CR>", {})
		end,
	})

	-- lsp
	-- https://github.com/neovim/nvim-lspconfig
	-- https://github.com/iamcco/diagnostic-languageserver
	-- use({
	-- 	"nvim-lua/completion-nvim",
	-- 	config = function()
	-- 		vim.cmd([[set completeopt=menuone,noinsert,noselect]])
	-- 		vim.cmd([[set shortmess+=c]])
	-- 	end,
	-- })
	use({
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init({
				-- enables text annotations
				--
				-- default: true
				with_text = true,

				-- default symbol map
				-- can be either 'default' or
				-- 'codicons' for codicon preset (requires vscode-codicons font installed)
				--
				-- default: 'default'
				preset = "codicons",

				-- override preset symbols
				--
				-- default: {}
				symbol_map = {
					Text = "",
					Method = "ƒ",
					Function = "",
					Constructor = "",
					Variable = "",
					Class = "",
					Interface = "ﰮ",
					Module = "",
					Property = "",
					Unit = "",
					Value = "",
					Enum = "了",
					Keyword = "",
					Snippet = "﬌",
					Color = "",
					File = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "",
				},
			})
		end,
	})
	use({
		"hrsh7th/nvim-compe",
		config = function()
			require("compe").setup({
				enabled = true,
				autocomplete = true,
				debug = false,
				min_length = 1,
				preselect = "enable",
				throttle_time = 80,
				source_timeout = 200,
				resolve_timeout = 800,
				incomplete_delay = 400,
				max_abbr_width = 100,
				max_kind_width = 100,
				max_menu_width = 100,
				documentation = {
					border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
					winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
					max_width = 120,
					min_width = 60,
					max_height = math.floor(vim.o.lines * 0.3),
					min_height = 1,
				},

				source = {
					path = true,
					buffer = true,
					calc = true,
					nvim_lsp = true,
					nvim_lua = true,
					vsnip = true,
					ultisnips = true,
					luasnip = true,
				},
			})

			local t = function(str)
				return vim.api.nvim_replace_termcodes(str, true, true, true)
			end

			local check_back_space = function()
				local col = vim.fn.col(".") - 1
				if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
					return true
				else
					return false
				end
			end

			-- Use (s-)tab to:
			--- move to prev/next item in completion menuone
			--- jump to prev/next snippet's placeholder
			_G.tab_complete = function()
				if vim.fn.pumvisible() == 1 then
					return t("<C-n>")
				elseif check_back_space() then
					return t("<Tab>")
				else
					return vim.fn["compe#complete"]()
				end
			end
			_G.s_tab_complete = function()
				if vim.fn.pumvisible() == 1 then
					return t("<C-p>")
				else
					return t("<S-Tab>")
				end
			end

			vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
			vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
			vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
			vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		config = function()
			vim.api.nvim_set_var("lsp_signs_enabled", 1)
			vim.api.nvim_set_var("lsp_diagnostics_enabled", 1)
			vim.api.nvim_set_var("lsp_diagnostics_echo_cursor", 1)
			vim.api.nvim_set_var("lsp_virtual_text_enabled", 1)
			-- vim.api.nvim_set_var("lsp_signs_error", { text = "✗" })
			-- vim.api.nvim_set_var("lsp_signs_warning", { text = "‼" })
			-- vim.api.nvim_set_var("lsp_signs_information", { text = "i" })
			-- vim.api.nvim_set_var("lsp_signs_hint", { text = "?" })
		end,
	})
	use({
		"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
		config = function()
			-- require("toggle_lsp_diagnostics").init({ underline = false, virtual_text = { prefix = "XXX", spacing = 5 } })
		end,
	})

	-- dap
	-- Plug 'mfussenegger/nvim-dap'
	use({ "ousttrue/nvim-dap", config = function() end })
	use({
		"nvim-telescope/telescope-dap.nvim",
		config = function()
			require("telescope").load_extension("dap")
		end,
	})
	use({
		"mfussenegger/nvim-dap-python",
		config = function()
			-- require('dap-python').setup('~/miniconda3/bin/python')
			local opt = { noremap = true }
			vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opt)
			-- vim.api.nvim_set_keymap("n", "<leader>dd", ":lua require('dap').continue()<CR>", opt)
			vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opt)
			vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opt)
			vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opt)
			vim.api.nvim_set_keymap("n", ",b", ":lua require'dap'.toggle_breakpoint()<CR>", opt)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>B",
				":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				opt
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>lp",
				":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				opt
			)
			vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opt)
			vim.api.nvim_set_keymap("n", "<leader>dl", ":lua require'dap'.repl.run_last()<CR>`", opt)
			vim.api.nvim_set_keymap("n", "<leader>dn", ":lua require('dap-python').test_method()<CR>", opt)
			vim.api.nvim_set_keymap("n", "<leader>ds <ESC>", ":lua require('dap-python').debug_selection()<CR>", opt)
		end,
	})
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "ousttrue/nvim-dap" },
		config = function()
			require("dapui").setup()

			require("dapui").setup({
				icons = { expanded = "⯆", collapsed = "⯈" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
				},
				sidebar = {
					open_on_start = true,
					elements = {
						-- You can change the order of elements in the sidebar
						"scopes",
						"breakpoints",
						"stacks",
						"watches",
					},
					width = 40,
					position = "left", -- Can be "left" or "right"
				},
				tray = {
					open_on_start = true,
					elements = { "repl" },
					height = 10,
					position = "bottom", -- Can be "bottom" or "top"
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
				},
			})
		end,
	})

	-- snippet
	-- https://github.com/norcalli/snippets.nvim
	use("norcalli/snippets.nvim")

	-- edit
	use({
		"tpope/vim-commentary",

		config = function()
			vim.api.nvim_set_keymap("n", "<C-_>", ":Commentary<CR>", {})
			vim.api.nvim_set_keymap("v", "<C-_>", ":Commentary<CR>", {})
			vim.api.nvim_set_keymap("n", "<C-/>", ":Commentary<CR>", {})
			vim.api.nvim_set_keymap("v", "<C-/>", ":Commentary<CR>", {})
		end,
	})
	use("tpope/vim-surround")
	use({
		-- "jiangmiao/auto-pairs",
		"LunarWatcher/auto-pairs",
		config = function()
			vim.api.nvim_set_var("AutoPairsCompleteOnlyOnSpace", 1)
		end,
	})

	-- formatter
	use({
		"sbdchd/neoformat",
		config = function()
			vim.api.nvim_set_keymap("n", "<A-F>", ":Neoformat<CR>", {})
			vim.cmd("let g:neoformat_enabled_python = ['yapf']")
		end,
	})

	-- fold
	-- use("arecarn/vim-fold-cycle")

	-- gx
	use({
		"tyru/open-browser.vim",
		config = function()
			vim.api.nvim_set_var("netrw_nogx", true) -- " disable netrw's gx mapping
			vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", {})
			vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", {})
		end,
	})
	-- use("LumaKernel/open-browser.vim")

	--
	-- filetypes
	--
	use("sheerun/vim-polyglot")
	use("norcalli/nvim-colorizer.lua")

	-- use("cdelledonne/vim-cmake")
	use("ilyachur/cmake4vim")

	-- markdown
	-- use("vim-voom/VOoM")
	use("rhysd/vim-gfm-syntax")
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

vim.cmd("PackerInstall")
