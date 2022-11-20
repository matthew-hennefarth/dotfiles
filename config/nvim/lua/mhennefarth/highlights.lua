
-- This can replace the gruvbox theme in the plugins/gruvbox.lua file
-- local ok, _ = pcall(vim.cmd, "colorscheme base16-gruvbox-dark-medium")

-- Highlight the region on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = num_au,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
	end,
})

