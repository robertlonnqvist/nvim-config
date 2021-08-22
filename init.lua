  
require('packer').startup(function()

  use 'wbthomason/packer.nvim'

  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'navarasu/onedark.nvim'
  use 'editorconfig/editorconfig-vim'
  use 'HerringtonDarkholme/yats.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'sheerun/vim-polyglot'

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

end)

require('lualine').setup {options = {theme = 'onedark'}}
require('gitsigns').setup()

vim.opt.clipboard = 'unnamedplus'

-- if hidden is not set, TextEdit might fail.
vim.opt.hidden = true
-- don't give |ins-completion-menu| messages.
--vim.opt.shortmess:append({ c = true })
-- always show signcolumns
vim.opt.signcolumn = 'yes'

-- displayed by the lualine plugin
vim.opt.showmode = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.title = true

-- having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

vim.g.mapleader = ' '

vim.opt.list = true

-- tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
-- use white spaces instead of tabs
vim.opt.expandtab = true
vim.opt.colorcolumn = '120'

vim.opt.termguicolors = true
vim.cmd [[colorscheme onedark]]

vim.opt.spelllang = 'en_us'

-- spell-check Markdown files and Git Commit Messages
vim.cmd [[autocmd FileType markdown setlocal spell complete+=kspell]]
vim.cmd [[autocmd FileType gitcommit setlocal spell complete+=kspell]]

vim.opt.splitbelow = true
vim.opt.splitright = true

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<c-up>', '<cmd>resize +2<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-down>', '<cmd>resize -2<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-left>', '<cmd>vertical resize•+2<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-right>', '<cmd>vertical resize•-2<cr>', opts)

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)

-- LSP
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync{}]]

nvim_lsp.tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
}

local filetypes = {
  typescript = 'eslint',
  typescriptreact = 'eslint',
}
local linters = {
  eslint = {
    sourceName = 'eslint',
    command = 'eslint_d',
    rootPatterns = {'.eslintrc.js', 'package.json'},
    debounce = 100,
    args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
    parseJson = {
      errorsRoot = '[0].messages',
      line = 'line',
      column = 'column',
      endLine = 'endLine',
      endColumn = 'endColumn',
      message = '${message} [${ruleId}]',
      security = 'severity'
    },
    securities = {[2] = 'error', [1] = 'warning'}
  }
}
local formatters = {
  prettier = {command = 'prettier', args = {'--stdin-filepath', '%filepath'}}
}
local formatFiletypes = {
  typescript = 'prettier',
  typescriptreact = 'prettier'
}
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = vim.tbl_keys(filetypes),
  init_options = {
    filetypes = filetypes,
    linters = linters,
    formatters = formatters,
    formatFiletypes = formatFiletypes
  }
}

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- Compe setup
vim.opt.completeopt = { 'menuone', 'noinsert' }
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return termcodes '<C-n>'
  elseif check_back_space() then
    return termcodes '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return termcodes '<C-p>'
  else
    return termcodes '<S-Tab>'
  end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

--This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

