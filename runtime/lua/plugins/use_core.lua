return function(use)
    use "Shougo/context_filetype.vim"
    use "osyo-manga/vim-precious"
    use "cespare/vim-toml"

    use "tpope/vim-surround"
    use "tpope/vim-fugitive"
    use {
        "tpope/vim-commentary",
        config = function()
            vim.api.nvim_set_keymap("n", "<C-_>", ":Commentary<CR>", { noremap = true })
            vim.api.nvim_set_keymap("v", "<C-_>", ":Commentary<CR>", { noremap = true })
        end,
    }

    -- use "itchyny/lightline.vim"
    -- use "adelarsq/neoline.vim"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup()
        end,
    }
    use {
        "Chiel92/vim-autoformat",
        config = function()
            vim.api.nvim_set_keymap("n", "<S-f>", ":Autoformat<CR>", { noremap = true })
            vim.api.nvim_set_keymap("v", "<S-f>", ":Autoformat<CR>", { noremap = true })
        end,
    }

    use {
        "preservim/nerdtree",
        config = function()
            vim.api.nvim_set_var("NERDTreeGitStatusUseNerdFonts", 1)
            vim.api.nvim_set_var("NERDTreeBookmarksFile", 1)
            vim.api.nvim_set_keymap("n", "<Space><Space>", ":NERDTreeVCS<CR>", { noremap = true })
        end,
    }

    use "nathanaelkane/vim-indent-guides"

    use {
        "simeji/winresizer",
        config = function()
            -- vim.api.nvim_set_var("winresizer_start_key", "<C-T>")
        end,
    }

    use "godlygeek/tabular"
    use {
        "plasticboy/vim-markdown",
        config = function()
            vim.api.nvim_set_var("vim_markdown_folding_disabled", 1)
            vim.api.nvim_set_var("vim_markdown_new_list_item_indent", 0)
        end,
    }
    use "tyru/open-browser.vim"

    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            -- Using Lua functions
            vim.api.nvim_set_keymap(
                "n",
                "<leader>ff",
                "<cmd>lua require('telescope.builtin').git_files()<cr>",
                { noremap = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>fg",
                "<cmd>lua require('telescope.builtin').live_grep()<cr>",
                { noremap = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>fb",
                "<cmd>lua require('telescope.builtin').buffers()<cr>",
                { noremap = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>fh",
                "<cmd>lua require('telescope.builtin').help_tags()<cr>",
                { noremap = true }
            )
        end,
    }
end
