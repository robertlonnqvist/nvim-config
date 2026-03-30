vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
})

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
})

vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
})

local servers = { 'lua_ls', 'pyright', 'ts_ls', 'html', 'cssls' }
for _, name in ipairs(servers) do
  local config = vim.lsp.config[name]
  if config and config.cmd and vim.fn.executable(config.cmd[1]) == 1 then
    vim.lsp.enable(name)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion', { bufnr = args.buf }) then
      vim.lsp.completion.enable(true, client.id)
    end
  end,
})

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
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
