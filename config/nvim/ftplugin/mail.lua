vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.fo:append("wq")
vim.opt_local.comments:append("nb:>")

map("n", "<localleader>ll", ":MarkdownPreviewToggle<CR>")
