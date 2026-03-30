vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

local ts = require('nvim-treesitter')

ts.setup({
  highlight = { enable = true },
  indent = { enable = true },
})

ts.install({
  'bash',
  'c',
  'css',
  'html',
  'javascript',
  'json',
  'lua',
  'markdown',
  'python',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
})
