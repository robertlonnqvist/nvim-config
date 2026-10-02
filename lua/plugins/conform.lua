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
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    jsonc = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    python = { 'ruff_format' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    zsh = { 'shfmt' },
    toml = { 'taplo' },
    nix = { 'nixfmt' },
  },
  format_on_save = { timeout_ms = 3000, lsp_format = 'fallback' },
})

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  conform.format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })
