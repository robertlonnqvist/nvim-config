vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

local languages = {
  'bash',
  'css',
  'html',
  'javascript',
  'json',
  'python',
  'tsx',
  'typescript',
  'yaml',
}

require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
