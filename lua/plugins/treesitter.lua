vim.pack.add({
  { src = 'https://github.com/romus204/tree-sitter-manager.nvim' },
})

local tsm = require('tree-sitter-manager')

tsm.setup({
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = {
    'bash',
    'css',
    'html',
    'javascript',
    'json',
    'python',
    'tsx',
    'typescript',
    'yaml',
  },
})
