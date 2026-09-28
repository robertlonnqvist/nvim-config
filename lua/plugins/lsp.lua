local servers = { 'lua_ls', 'ruff', 'pyright', 'ts_ls', 'html', 'cssls' }
for _, name in ipairs(servers) do
  local config = vim.lsp.config[name]
  if config and config.cmd and vim.fn.executable(config.cmd[1]) == 1 then
    vim.lsp.enable(name)
  end
end

local lsp_group = vim.api.nvim_create_augroup('user_lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion', { bufnr = args.buf }) then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { buffer = args.buf, desc = 'Manually trigger LSP completion' })
    end
  end,
})

vim.api.nvim_create_autocmd('CursorHold', {
  group = lsp_group,
  callback = function()
    -- skip if we are in a window that's already a float or something else
    if vim.api.nvim_win_get_config(0).zindex then
      return
    end

    local opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

vim.keymap.set('i', '<CR>', function()
  if vim.fn.pumvisible() == 1 then
    -- Accepts the currently selected match
    return '<C-y>'
  else
    -- Performs a normal return/new line if the menu is closed
    return '<CR>'
  end
end, { expr = true, desc = 'Confirm completion with Enter' })
