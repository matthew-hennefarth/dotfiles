require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "rust_analyzer", "texlab", "pyright", "lua_ls", "marksman", "fortls" },
})
