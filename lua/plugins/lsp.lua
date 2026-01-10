return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      vim.lsp.config('lua_ls', {
        settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "html", "cssls" },
      })
    end,
  },
}
