return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')

      ts.setup({
        highlight = { enable = true },
        indent = { enable = true },
      })

      ts.install({
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      })
    end
  }
}
