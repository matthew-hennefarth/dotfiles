require("nvim-treesitter.config").setup({
  ensure_installed = { "cpp", "python", "lua", "rust", "fortran", "bibtex", "markdown", "vimdoc" },
  sync_install = false,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = { "latex", "markdown" },
  },
  indent = {
    enable = true,
    disable = { "" },
  },
})
