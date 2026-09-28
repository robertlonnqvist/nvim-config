local bufnr = vim.api.nvim_get_current_buf()

-- 1. Coding Tools & Refactoring
vim.keymap.set('n', '<leader>a', function()
  vim.cmd.RustLsp('codeAction')
end, { silent = true, buffer = bufnr, desc = 'Rust Code Actions' })

vim.keymap.set('n', 'K', function()
  vim.cmd.RustLsp({ 'hover', 'actions' })
end, { silent = true, buffer = bufnr, desc = 'Rust Hover Actions' })

vim.keymap.set('n', '<leader>ex', function()
  vim.cmd.RustLsp('explainError')
end, { silent = true, buffer = bufnr, desc = 'Explain Rust Error' })

-- 2. Running, Testing & Debugging
vim.keymap.set('n', '<leader>rr', function()
  vim.cmd.RustLsp('runnables')
end, { silent = true, buffer = bufnr, desc = 'Rust Runnables Menu' })

vim.keymap.set('n', '<leader>rd', function()
  vim.cmd.RustLsp('debuggables')
end, { silent = true, buffer = bufnr, desc = 'Rust Debuggables Menu' })

-- 3. Navigation & Generation
vim.keymap.set('n', '<leader>rc', function()
  vim.cmd.RustLsp('openCargo')
end, { silent = true, buffer = bufnr, desc = 'Open Cargo.toml' })

vim.keymap.set('n', '<leader>rp', function()
  vim.cmd.RustLsp('parentModule')
end, { silent = true, buffer = bufnr, desc = 'Jump to Parent Module' })

vim.keymap.set('n', '<leader>rm', function()
  vim.cmd.RustLsp({ 'expandMacro', 'vertical' })
end, { silent = true, buffer = bufnr, desc = 'Expand Macro Recursively' })
