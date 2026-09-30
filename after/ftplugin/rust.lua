-- 1. Coding Tools & Refactoring
vim.keymap.set('n', 'K', function()
  vim.cmd.RustLsp({ 'hover', 'actions' })
end, { silent = true, buffer = true, desc = 'Rust Hover Actions' })

vim.keymap.set('n', '<leader>rx', function()
  vim.cmd.RustLsp('explainError')
end, { silent = true, buffer = true, desc = 'Explain Rust Error' })

-- 2. Running, Testing & Debugging
vim.keymap.set('n', '<leader>rr', function()
  vim.cmd.RustLsp('runnables')
end, { silent = true, buffer = true, desc = 'Rust Runnables Menu' })

vim.keymap.set('n', '<leader>rd', function()
  vim.cmd.RustLsp('debuggables')
end, { silent = true, buffer = true, desc = 'Rust Debuggables Menu' })

vim.keymap.set('n', '<leader>rt', function()
  vim.cmd.RustLsp({ 'testables', 'current' })
end, { silent = true, buffer = true, desc = 'Run closest test' })

-- 3. Navigation & Generation
vim.keymap.set('n', '<leader>rc', function()
  vim.cmd.RustLsp('openCargo')
end, { silent = true, buffer = true, desc = 'Open Cargo.toml' })

vim.keymap.set('n', '<leader>rp', function()
  vim.cmd.RustLsp('parentModule')
end, { silent = true, buffer = true, desc = 'Jump to Parent Module' })

vim.keymap.set('n', '<leader>rm', function()
  vim.cmd.RustLsp({ 'expandMacro', 'vertical' })
end, { silent = true, buffer = true, desc = 'Expand Macro Recursively' })

vim.keymap.set('n', '<leader>rl', function()
  vim.cmd.RustLsp('viewAsm') -- Or 'renderDiagnostic' depending on compiler versions
end, { silent = true, buffer = true, desc = 'View assembly/MIR data' })
