require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.undofile = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- spelling
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "gitrebase", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.complete:append("kspell")
  end,
})
