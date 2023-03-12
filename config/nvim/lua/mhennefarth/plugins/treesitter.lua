require('nvim-treesitter.configs').setup {
  ensure_installed = {"cpp", "python", "lua", "rust", "fortran"},
  sync_install = false,
  ignore_install = {""},
  highlight = {
    enable = true,
    disable = {""},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true, 
    disable = {""}
  },
}
