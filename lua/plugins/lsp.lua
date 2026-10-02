vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})

-- custom overrides for lsp's
vim.lsp.config('pyright', {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = { diagnosticMode = 'openFilesOnly' } },
  },
})

vim.lsp.config('ruff', {
  on_attach = function(c)
    c.server_capabilities.hoverProvider = false
  end,
})

vim.lsp.config('lua_ls', {
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})

vim.lsp.config('nil_ls', {
  settings = {
    ['nil'] = {
      nix = {
        flake = {
          autoArchive = true,
        },
      },
    },
  },
})

local servers = {
  'ruff',
  'lua_ls',
  'pyright',
  'ts_ls',
  'html',
  'cssls',
  'jsonls',
  'bashls',
  'eslint',
  'nil_ls',
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- lsp configs
local lsp_group = vim.api.nvim_create_augroup('user_lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- enable Codelens if supported (Trigger action via global default mapping 'grx')
    if client:supports_method('textDocument/codeLens', { bufnr = args.buf }) then
      vim.lsp.codelens.enable(true, { bufnr = args.buf })
    end

    -- enable Inlay Hints if supported
    if client:supports_method('textDocument/inlayHint', { bufnr = args.buf }) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    -- enable native autocomplete triggers
    if client:supports_method('textDocument/completion', { bufnr = args.buf }) then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { buffer = args.buf, desc = 'Manually trigger LSP completion' })
    end
  end,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
  virtual_text = {
    spacing = 4,
    prefix = '●',
  },
  virtual_lines = false,
  underline = true,
  severity_sort = true,
  float = { border = 'rounded', source = true },
})

-- virtual_lines truncates at window width with wrap off; the float is focusable
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float({ focus = true, scope = 'line' })
end, { desc = 'Show diagnostic float' })

vim.keymap.set('i', '<CR>', function()
  -- only confirm when an entry is actually selected, otherwise insert a newline
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ 'selected' }).selected ~= -1 then
    return '<C-y>'
  end
  return '<CR>'
end, { expr = true, desc = 'Confirm completion with Enter' })
