return function(use)
    use {
        "tyru/eskk.vim",
        config = function()
            -- "https://alwei.hatenadiary.org/entry/20111029/1319905783
            vim.api.nvim_set_var("eskk#directory", "~/.eskk")
            vim.api.nvim_set_var("eskk#dictionary", { path = "~/.skk-jisyo", sorted = 0, encoding = "utf-8" })
            vim.api.nvim_set_var(
                "eskk#large_dictionary",
                { path = "~/.eskk/SKK-JISYO.L", sorted = 1, encoding = "euc-jp" }
            )
            vim.api.nvim_set_var("eskk#enable_completion", 1)
            -- vim.o.imdisable = 1

            -- https://zenn.dev/kouta/articles/87947515bff4da
            vim.api.nvim_set_var("eskk#kakutei_when_unique_candidate", 1) -- 漢字変換した時に候補が1つの場合、自動的に確定する
            vim.api.nvim_set_var("eskk#enable_completion", 0) -- neocompleteを入れないと、1にすると動作しなくなるため0推奨
            vim.api.nvim_set_var("eskk#no_default_mappings", 1) -- デフォルトのマッピングを削除
            vim.api.nvim_set_var("eskk#keep_state", 0) -- ノーマルモードに戻るとeskkモードを初期値にする
            vim.api.nvim_set_var("eskk#egg_like_newline", 1) -- 漢字変換を確定しても改行しない。
            vim.api.nvim_set_var("eskk#marker_henkan", "[変換]")
            vim.api.nvim_set_var("eskk#marker_henkan_select", "[選択]")
            vim.api.nvim_set_var("eskk#marker_okuri", "[送り]")
            vim.api.nvim_set_var("eskk#marker_jisyo_touroku", "[辞書]")

            vim.cmd [[
"exit eskk by l"
augroup vimrc_eskk
  autocmd!
  autocmd User eskk-enable-post lmap <buffer> l <Plug>(eskk:disable)
  autocmd InsertEnter *.md if g:md_auto_eskk | call eskk#enable() | endif
augroup END

let g:md_auto_eskk = 1

imap <C-j> <Plug>(eskk:toggle)
cmap <C-j> <Plug>(eskk:toggle)
]]
        end,
    }
end
