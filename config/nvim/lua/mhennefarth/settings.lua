local g = vim.g
local o = vim.o

-- Some color settings
o.termguicolors = true

-- General settings for a better UI
o.tabstop = 2
o.expandtab = true
o.number = true
o.relativenumber = true
o.showmatch = true
o.smarttab = true
o.smartindent = true
o.shiftwidth = 2
o.laststatus = 2
o.linebreak = true -- lines wrap at words rathern than random characters
o.colorcolumn = "+1" -- Set the colour column to highlight one column after the 'textwidth'

-- Highlighting when searching for text
o.hlsearch = false
o.incsearch = true

-- General Cleanup
o.viminfo = "%,<800,'10,/50,:100,h,f0,n~/.cache/viminfo"

-- Mouse usage stuff
vim.cmd [[set mouse=v]]

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- For commenting and other
g.mapleader = ','
