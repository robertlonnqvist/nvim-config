vim.pack.add({
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
})

local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = { height = 0.85, width = 0.90 },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({}),
    },
  },
})

telescope.load_extension('ui-select')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Project Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep Search Text' })
vim.keymap.set('n', 'grr', builtin.lsp_references, { desc = 'TS/Global: View References in Telescope' })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'TS/Global: Go to Definition' })
vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { desc = 'TS/Global: Go to Type Definition' })
vim.keymap.set('n', 'gri', builtin.lsp_implementations, { desc = 'TS/Global: Go to Implementation' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Global: View Project Errors & Warnings' })
