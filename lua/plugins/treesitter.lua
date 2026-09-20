vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user_treesitter', { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
