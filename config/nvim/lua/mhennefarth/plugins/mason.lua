require("mason").setup()

require("mason-lspconfig").setup({
  automatic_enable = { "texlab", "lua_ls", "jedi_language_server", "ruff", "marksman", "fortls" },
})
