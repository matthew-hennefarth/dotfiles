require('nvim-treesitter.configs').setup {
  ensure_installed = {"cpp", "python", "lua", "rust", "fortran", "bibtex"},
  sync_install = false,
  ignore_install = {""},
  highlight = {
    enable = true,
    disable = {"latex"},
    additional_vim_regex_highlighting = {"latex", "markdown"},
  },
  indent = {
    enable = true, 
    disable = {""}
  },
}
