return function(use)
    use "Shougo/context_filetype.vim"
    use "osyo-manga/vim-precious"
    use "cespare/vim-toml"

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
            -- vim.api.nvim_set_keymap("n", ",,", ":NERDTreeFind<CR>", { noremap = true })
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
        end,
    }
    use "tyru/open-browser.vim"
end
