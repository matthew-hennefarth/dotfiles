require("gruvbox").setup({
  terminal_colors = true,
  italic = {
    strings = false,
    operators = false,
    comments = true,
  },
  overrides = {
    SignColumn = {bg = "none"}
  }
})

local ok, _ = pcall(vim.cmd, "colorscheme gruvbox")

-- Allows transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
