-------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<C-n>", ":NvimTreeToggle<CR>")

-- vim easy align plugin
map("n", "<leader>a", "<Plug>(EasyAlign)")
map("v", "<leader>a", "<Plug>(EasyAlign)")
