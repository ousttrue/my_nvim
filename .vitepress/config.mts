import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "vim memo",
  description: "my nvim info",
  srcDir: "docs",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
    ],

    sidebar: [
      {
        text: 'customize',
        link: '/customize/',
        items: [
          { text: 'keymap', link: '/customize/keymap' },
          { text: 'vimrc', link: '/customize/vimrc' },
        ]
      },
      {
        text: 'nvim',
        link: '/nvim/',
        items: [
          { text: 'articles', link: '/nvim/articles' },
          { text: 'lua', link: '/nvim/lua' },
          { text: 'luv', link: '/nvim/luv' },
          { text: 'nivm', link: '/nvim/nvim' },
          { text: 'terminal', link: '/nvim/terminal' },
        ]
      },
      {
        text: 'lsp',
        link: '/lsp/',
        items: [
          { text: 'ale', link: '/lsp/ale' },
          { text: 'coc', link: '/lsp/coc' },
          { text: 'nvim-lsp', link: '/lsp/nvim-lsp' },
          { text: 'vim-lsp', link: '/lsp/vim-lsp' },
        ]
      },
      {
        text: 'languages',
        link: '/languages/',
        items: [
          { text: 'markdown', link: '/languages/markdown' },
          { text: 'python', link: '/languages/python' },
          { text: 'rust', link: '/languages/rust' },
        ]
      },
      {
        text: 'plugins',
        link: '/plugins/',
        items: [
          { text: 'comment', link: '/plugins/comment' },
          { text: 'dein', link: '/plugins/dein' },
          { text: 'git', link: '/plugins/git' },
          { text: 'skk', link: '/plugins/skk' },
          { text: 'statusline', link: '/plugins/statusline' },
          {
            text: 'FuzzyFinder',
            link: '/plugins/fuzzy_finder/',
            items: [
              { text: 'denite', link: '/plugins/fuzzy_finder/denite' },
              { text: 'telescope', link: '/plugins/fuzzy_finder/telescope' },
            ]
          },
        ]
      },
      {
        text: 'Debugger',
        items: [
          { text: 'nvim-dap', link: '/debugger/nvim-dap' },
          { text: 'vimspector', link: '/debugger/vimspector' },
        ]
      },
      {
        text: 'Vim',
        link: '/vim/',
        items: [
          { text: 'autocmd', link: '/vim/autocmd' },
          { text: 'buffer', link: '/vim/buffer' },
          { text: 'colorschema', link: '/vim/colorschema' },
          { text: 'completion', link: '/vim/completion' },
          { text: 'env', link: '/vim/env' },
          { text: 'filetypes', link: '/vim/filetypes' },
          { text: 'fold', link: '/vim/fold' },
          { text: 'index', link: '/vim/index' },
          { text: 'nvim', link: '/vim/nvim' },
          { text: 'packer', link: '/vim/packer' },
          { text: 'quickfix', link: '/vim/quickfix' },
          { text: 'signcolumn', link: '/vim/signcolumn' },
          { text: 'terminal', link: '/vim/terminal' },
        ]
      },
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ousttrue/my_nvim' }
    ]
  }
})
