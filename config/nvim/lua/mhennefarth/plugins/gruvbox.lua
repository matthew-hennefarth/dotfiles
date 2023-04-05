require("gruvbox").setup({
  italic = false,
})

local ok, _ = pcall(vim.cmd, "colorscheme gruvbox")

-- Allows transparent background
vim.cmd [[
  hi Normal guibg=none
  hi NonText guibg=none
]]
