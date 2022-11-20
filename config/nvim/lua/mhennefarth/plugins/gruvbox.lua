require("gruvbox").setup({
  italic = false,
})

local ok, _ = pcall(vim.cmd, "colorscheme gruvbox")
