vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
})

vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
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

vim.api.nvim_create_autocmd('CursorHold', {
  group = lsp_group,
  callback = function()
    -- skip if we are in a window that's already a float or something else
    if vim.api.nvim_win_get_config(0).zindex then
      return
    end

    -- skip if diagnostics are missing on current line
    if #vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 }) == 0 then
      return
    end

    -- If any window is a float, stop immediately so we don't blink/close it!
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative and config.relative ~= '' then
        return -- A float is already open (like explainError), abort loop!
      end
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
