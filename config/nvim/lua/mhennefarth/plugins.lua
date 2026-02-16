local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Simple plugins
  "preservim/nerdcommenter",
  "jiangmiao/auto-pairs",
  "junegunn/vim-easy-align",
  "tpope/vim-fugitive",
  "RRethy/nvim-base16",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "mrcjkb/rustaceanvim",
  "lervag/vimtex",
  "adborden/vim-notmuch-address",
  "codybuell/cmp-lbdb",
  "mrded/nvim-lsp-notify",

  -- Colorscheme (Setting priority so it loads first)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("mhennefarth.plugins.gruvbox")
    end,
  },

  -- UI & Status
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("mhennefarth.plugins.lualine")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("mhennefarth.plugins.tree")
    end,
  },

  -- Treesitter (using 'build' instead of 'run')
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("mhennefarth.plugins.treesitter")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("mhennefarth.plugins.indent-blankline")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("mhennefarth.plugins.gitsigns")
    end,
  },

  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("mhennefarth.plugins.tmux-navigation")
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("mhennefarth.plugins.notify")
    end,
  },

  -- Completion & LSP
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("mhennefarth.plugins.cmp")
    end,
  },


  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
      require("mhennefarth.plugins.mason")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mhennefarth.plugins.lspconfig")
    end,
  },

  -- Linting & Formatting
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("mhennefarth.plugins.lint")
    end,
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require("mhennefarth.plugins.conform")
    end,
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown", "mail" }, -- This replaces the 'setup' filetype logic
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "mail" }
    end,
  },
})
