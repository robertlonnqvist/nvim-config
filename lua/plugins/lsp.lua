vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  settings = {
    -- ruff owns linting; pyright is type-checking only
    pyright = { disableOrganizeImports = true },
    python = { analysis = { diagnosticMode = 'openFilesOnly' } },
  },
})

vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  on_attach = function(client)
    -- defer hover to pyright to avoid duplicate popups
    client.server_capabilities.hoverProvider = false
  end,
})

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html', 'xhtml' },
  root_markers = { 'package.json', '.git' },
})

vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
})

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
})

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
})

vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  -- Help the engine attach properly based on common lint rules or monorepo roots
  root_markers = {
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    '.eslintrc.json',
    '.eslintrc.js',
    'package.json',
    '.git',
  },
  settings = {
    validate = 'on',
    useESLintClass = true,
    nodePath = '',
    rulesCustomizations = {},
    problems = {},
    workingDirectory = { mode = 'auto' },
    experimental = {},
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = { enable = true },
    },
  },
})

local servers = { 'lua_ls', 'ruff', 'pyright', 'ts_ls', 'html', 'cssls', 'jsonls', 'bashls', 'eslint' }
for _, name in ipairs(servers) do
  vim.lsp.enable(name)
end

local lsp_group = vim.api.nvim_create_augroup('user_lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client:supports_method('textDocument/codeLens', { bufnr = args.buf }) then
      vim.lsp.codelens.enable(true, { bufnr = args.buf })
      vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.run, {
        buffer = args.buf,
        desc = 'LSP: Run CodeLens Action',
      })
    end

    if client:supports_method('textDocument/inlayHint', { bufnr = args.buf }) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    if client:supports_method('textDocument/completion', { bufnr = args.buf }) then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { buffer = args.buf, desc = 'Manually trigger LSP completion' })
    end
  end,
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
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
