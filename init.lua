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
vim.o.scrolloff = 8
vim.o.cursorline = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.title = true
vim.o.titlestring = 'nvim - %t'
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'
vim.o.completeopt = 'menuone,noselect,noinsert,popup'
vim.o.inccommand = 'split'
vim.o.smoothscroll = true
vim.o.virtualedit = 'block'
vim.o.wrap = false
vim.o.jumpoptions = 'view'
vim.opt.fillchars = { eob = ' ' }
vim.o.confirm = true

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste before from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Delete to system clipboard' })

-- spelling
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('spelling_group', { clear = true }),
  pattern = { 'gitcommit', 'gitrebase', 'markdown' },
  callback = function()
    vim.wo.spell = true
    -- adds dictionary words to the Ctrl-n / Ctrl-p completion list
    if not vim.bo.complete:find('kspell') then
      vim.bo.complete = vim.bo.complete .. ',kspell'
    end
  end,
})

-- create parent dirs when saving
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
  callback = function(ctx)
    if ctx.match:match('^%w%w+:[\\/]') then
      return
    end
    local dir = vim.fn.fnamemodify(ctx.file, ':h')
    vim.fn.mkdir(dir, 'p')
  end,
})

-- Visual feedback on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})