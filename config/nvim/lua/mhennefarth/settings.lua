local g = vim.g
local o = vim.o

-- Some color settings
o.termguicolors = true
-- o.background = dark

-- General settings for a better UI
o.tabstop = 2
o.expandtab = true
o.number = true
o.showmatch = true
o.t_Co = 256
o.smarttab = true
o.smartindent = true
o.shiftwidth = 2
o.laststatus = 2

-- General Cleanup
o.viminfo = "%,<800,'10,/50,:100,h,f0,n~/.cache/viminfo"

-- Allows transparent background
vim.cmd [[
  hi Normal guibg=none
  hi NonText guibg=none
]]

-- For commenting and other
g.mapleader = ','
