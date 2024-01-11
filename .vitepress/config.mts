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
      { text: 'windows', link: '/windows' },
      { text: 'package_manager', link: '/package_manager' },
      { text: 'comment', link: '/comment' },
      { text: 'tree-sitter', link: '/tree-sitter/' },
      {
        text: 'lsp & formatter', link: '/lsp_formatter/',
        collapsed: true,
        items: [
          { text: 'lspconfig', link: '/lsp_formatter/lspconfig/' },
          { text: 'formatter', link: '/lsp_formatter/formatter/' },
        ]
      },
      { text: 'telescope', link: '/telescope' },
      { text: 'completion', link: '/completion' },
      { text: 'filer', link: '/filer' },
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ousttrue/my_nvim' }
    ]
  }
})
