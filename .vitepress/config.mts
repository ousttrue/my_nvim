import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "vim memo",
  description: "my nvim info",
  srcDir: "docs",
  base: "/my_nvim/",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
    ],

    sidebar: [
      {
        text: 'lua', items: [
          { text: "vim_module", link: '/lua/vim_module' },
          { text: "lua_module", link: '/lua/vim_lua_util' },
          { text: "lua_module", link: '/lua/lua_module' },
        ]
      },
      { text: 'windows', link: '/windows' },
      { text: 'package_manager', link: '/package_manager' },
      { text: 'comment', link: '/comment' },
      { text: 'tree-sitter', link: '/tree-sitter/' },
      {
        text: 'lsp & formatter', link: '/lsp_formatter/',
        collapsed: true,
        items: [
          { text: 'lspconfig', link: '/lsp_formatter/lspconfig/' },
          { text: 'null-ls', link: '/lsp_formatter/null-ls' },
          { text: 'formatter', link: '/lsp_formatter/formatter/' },
        ]
      },
      { text: 'telescope', link: '/telescope' },
      { text: 'completion', link: '/completion' },
      { text: 'filer', link: '/filer' },
      {
        text: 'highlight', items: [
          { text: 'colorenv', link: '/highlight/colorenv' },
          { text: 'inspect', link: '/highlight/inspect' },
          { text: 'highlightgroup', link: '/highlight/highlightgroup' },
          { text: 'colorscheme', link: '/highlight/colorscheme' },
          { text: 'make_colorscheme', link: '/highlight/make_colorscheme' },
          { text: 'syntax', link: '/highlight/syntax' },
          { text: 'floating', link: '/highlight/floating_window' },
        ]
      },
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ousttrue/my_nvim' }
    ]
  }
})
