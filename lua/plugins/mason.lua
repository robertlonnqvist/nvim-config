vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
})

require('mason').setup()

require('mason-tool-installer').setup({
  ensure_installed = {
    'stylua',
    'prettier',
    'shfmt',
    'ruff',
    'lua-language-server',
    'pyright',
    'typescript-language-server',
    'html-lsp',
    'css-lsp',
    'json-lsp',
    'bash-language-server',
    'shellcheck',
    'eslint-lsp',
    'taplo',
  },
})
