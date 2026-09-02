vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('plugins.colorscheme')
require('plugins.lualine')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.conform')
require('plugins.gitsigns')
require('plugins.which-key')

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.showmode = false
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.signcolumn = 'yes'
vim.o.colorcolumn = '120'
vim.o.clipboard = 'unnamedplus'
vim.o.scrolloff = 8
vim.o.cursorline = true
vim.o.undofile = true
vim.o.title = true
vim.o.titlestring = 'nvim - %t'
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'
vim.o.completeopt = 'menuone,noselect,noinsert,popup'

-- spelling
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'gitrebase', 'markdown' },
  callback = function()
    vim.wo.spell = true
    -- adds dictionary words to the Ctrl-n / Ctrl-p completion list
    vim.bo.complete = vim.bo.complete .. ',kspell'
  end,
})
