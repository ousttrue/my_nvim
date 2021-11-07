return function(use)
    -- treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            vim.cmd "TSUpdate"
            vim.cmd "TSInstall python"
            vim.cmd "TSInstall rust"
            vim.cmd "TSInstall lua"
            vim.cmd "TSInstall cpp"
            vim.cmd "TSInstall csharp"
            vim.cmd "TSInstall json"
            vim.cmd "TSInstall go"
        end,
        config = function()
            local ts = require "nvim-treesitter.configs"
            ts.setup {
                highlight = {
                    enable = true,
                    -- disable = {},
                },
                indent = {
                    -- enable = true,
                },
                -- ensure_installed = "maintained",
            }
        end,
    }
end
