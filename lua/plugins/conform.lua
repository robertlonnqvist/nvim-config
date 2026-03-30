vim.pack.add({
  { src = 'https://github.com/stevearc/conform.nvim' },
})

local conform = require('conform')
conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
  },
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
})

vim.keymap.set('', '<leader>f', function()
  conform.format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })
