return function(use)
    -- dap
    -- Plug 'mfussenegger/nvim-dap'
    use {
        "ousttrue/nvim-dap",
        requires = {
            { "mfussenegger/nvim-dap-python" },
        },
        config = function()
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

            require("dap").set_log_level "trace"
        end,
    }
end
