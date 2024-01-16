# TreeSitter
[[treesitter]]
- [2022年の nvim-treesitter の変更・新機能を振り返る](https://zenn.dev/vim_jp/articles/2022-12-25-vim-nvim-treesitter-2022-changes)
- @2022 [自作のVim colorschemeをTreesitterに対応させる](https://zenn.dev/hachy/scraps/88d761f329a9c8)
- @2022  [treesitter colorscheme](https://zenn.dev/botamotch/scraps/a9a64e9924564e)
- @2020 [君はまだVimの真の美しさを知らない - Qiita](https://qiita.com/psyashes/items/1e1716a59a0dc22ea204)

## hlargs
- [GitHub - m-demare/hlargs.nvim: Highlight arguments' definitions and usages, using Treesitter](https://github.com/m-demare/hlargs.nvim)


::: tip 整理する
:::

```lua
{
  "nvim-treesitter/nvim-treesitter",
  -- run = function()
  --   require("nvim-treesitter.install").update { with_sync = true }
  -- end,
  config = require("config.nvim-treesitter").setup,
  dependencies = "nvim-treesitter/playground",
},

local M = {}

function M.setup()
  -- パーサーのインストール先（任意）
  local treesitterpath = vim.fn.stdpath "cache" .. "/treesitter"
  vim.opt.runtimepath:append(treesitterpath)

  -- URIパーサーの設定追加
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.uri = {
    install_info = {
      url = "https://github.com/atusy/tree-sitter-uri",
      branch = "main",
      files = { "src/parser.c" },
      generate_requires_npm = false, -- if stand-alone parser without npm dependencies
      requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "uri", -- if filetype does not match the parser name
  }

  require("nvim-treesitter.configs").setup {
    parser_install_dir = treesitterpath,
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    matchup = {
      enable = true,
    },
    -- ensure_installed = "all",
    ensure_installed = {
      "query",
      -- "help" => vimdoc,
      "vimdoc",
      "c",
      "cpp",
      "python",
      "lua",
      "markdown",
      "markdown_inline",
      "zig",
      "html",
      "css",
      "c_sharp",
      "toml",
      "go",
      "bash",
      "json",
      "vala",
      "scss",
      "svelte",
      "typescript",
      "javascript",
      "tsx",
      "yaml",

      -- "nu",
      "uri",
    },

    indent = {
      enable = true,
      disable = {
        "c",
        "cpp",
      },
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    -- sync_install = true,

    -- List of parsers to ignore installing
    -- ignore_install = { "javascript" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is the name of the parser)
      -- list of language that will be disabled
      -- disable = { "lua" },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      -- additional_vim_regex_highlighting = false,
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["of"] = "@function.outer",
          ["if"] = "@function.inner",
          ["oc"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },

    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  }

  vim.treesitter.language.register("xml", "html")

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.fsharp = {
    install_info = {
      url = "https://github.com/Nsidorenco/tree-sitter-fsharp",
      branch = "develop",
      files = { "src/scanner.cc", "src/parser.c" },
      generate_requires_npm = true,
      requires_generate_from_grammar = true,
    },
    filetype = "fsharp",
  }
end

return M
```

