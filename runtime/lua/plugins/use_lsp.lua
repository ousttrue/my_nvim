return function(use)
    use "kizza/actionmenu.nvim"
    use "neovim/nvim-lspconfig"

    use {
        "onsails/lspkind-nvim",
        config = function()
            require("lspkind").init {
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
            }
        end,
    }
    use {
        "hrsh7th/nvim-compe",
        config = function()
            require("compe").setup {
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
            }

            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            local check_back_space = function()
                local col = vim.fn.col "." - 1
                if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
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
                    return t "<C-n>"
                elseif check_back_space() then
                    return t "<Tab>"
                else
                    return vim.fn["compe#complete"]()
                end
            end
            _G.s_tab_complete = function()
                if vim.fn.pumvisible() == 1 then
                    return t "<C-p>"
                else
                    return t "<S-Tab>"
                end
            end

            vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
            vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
            vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
            vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
        end,
    }
    use {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        config = function()
            -- require("toggle_lsp_diagnostics").init({ underline = false, virtual_text = { prefix = "XXX", spacing = 5 } })
        end,
    }
    use {
        "kosayoda/nvim-lightbulb",
        config = function()
            -- Showing defaults
            require("nvim-lightbulb").update_lightbulb {
                sign = {
                    enabled = true,
                    -- Priority of the gutter sign
                    priority = 10,
                },
                float = {
                    enabled = false,
                    -- Text to show in the popup float
                    text = "💡",
                    -- Available keys for window options:
                    -- - height     of floating window
                    -- - width      of floating window
                    -- - wrap_at    character to wrap at for computing height
                    -- - max_width  maximal width of floating window
                    -- - max_height maximal height of floating window
                    -- - pad_left   number of columns to pad contents at left
                    -- - pad_right  number of columns to pad contents at right
                    -- - pad_top    number of lines to pad contents at top
                    -- - pad_bottom number of lines to pad contents at bottom
                    -- - offset_x   x-axis offset of the floating window
                    -- - offset_y   y-axis offset of the floating window
                    -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
                    -- - winblend   transparency of the window (0-100)
                    win_opts = {},
                },
                virtual_text = {
                    enabled = false,
                    -- Text to show at virtual text
                    text = "💡",
                },
                status_text = {
                    enabled = false,
                    -- Text to provide when code actions are available
                    text = "💡",
                    -- Text to provide when no actions are available
                    text_unavailable = "",
                },
            }
            vim.fn.sign_define("LightBulbSign", { text = "", texthl = "", linehl = "", numhl = "" })
            -- vim.api.nvim_command("highlight LightBulbFloatWin ctermfg= ctermbg= guifg= guibg=")
            -- vim.api.nvim_command("highlight LightBulbVirtualText ctermfg= ctermbg= guifg= guibg=")
        end,
    }

end
