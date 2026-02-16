local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Neovim 0.11+ will now look in ~/.config/nvim/lsp/ for these specific names
local servers = {
  "zls",
  "jedi_language_server",
  "fortls",
  "marksman",
  "texlab",
  "lua_ls"
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

vim.diagnostic.config({
  float = { border = "rounded" }
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "rounded" }
)
