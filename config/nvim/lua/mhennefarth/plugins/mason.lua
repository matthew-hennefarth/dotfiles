require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "texlab", "lua_ls", "jedi_language_server", "ruff", "marksman", "fortls" },
})
