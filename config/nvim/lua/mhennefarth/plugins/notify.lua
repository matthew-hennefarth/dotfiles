require('notify').setup({
  background_colour = "#000000",
  render = "wrapped-compact",
  top_down = false,
  level = 3,
})

vim.notify = require("notify")
require('lsp-notify').setup()
