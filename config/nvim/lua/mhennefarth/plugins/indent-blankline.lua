require("ibl").setup {
  whitespace = {
    remove_blankline_trail = true,
  },
  exclude = {
    filetypes = {'tex', 'markdown'},
  },
  indent = {
    char = '┊'
  },
}

local hooks = require "ibl.hooks"
-- Hide first indent level
hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)
