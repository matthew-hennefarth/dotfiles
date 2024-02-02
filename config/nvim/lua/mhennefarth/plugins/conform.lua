local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		--bibtex = { "bibtex-tidy" },
		yaml = { "yamlfmt" },
		--tex = { "latexindent" },
		python = { "black" },
		-- mail = { "mdformat" },
		markdown = { "mdformat" },
	},
	--format_on_save = {
	--	lsp_fallback = true,
	--	async = false,
	--	timeout_ms = 1000,
	--},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 20000,
	})
end, { desc = "Format file or range (in visual mode)" })
