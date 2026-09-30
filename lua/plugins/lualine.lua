vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
})

local function active_lsp_servers()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if next(clients) == nil then
    return 'No LSP'
  end

  local server_names = {}
  for _, client in pairs(clients) do
    table.insert(server_names, client.name)
  end

  return '⚙️  [' .. table.concat(server_names, '|') .. ']'
end

require('lualine').setup({
  sections = {
    lualine_x = { active_lsp_servers, 'encoding', 'fileformat', 'filetype' },
  },
})
