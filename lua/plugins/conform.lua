vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/stevearc/conform.nvim' },
})

require('mason').setup()

local standalone_tools = { 'stylua', 'prettier', 'shfmt', 'shellcheck', 'taplo' }
local mr = require('mason-registry')

mr.refresh(function()
  for _, tool in ipairs(standalone_tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end)

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
  },
  format_on_save = { timeout_ms = 3000, lsp_format = 'fallback' },
})

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  conform.format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })
