
local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})


return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  use 'preservim/nerdcommenter' 
  use 'jiangmiao/auto-pairs'
 
  -- Different colorschemes
  use 'RRethy/nvim-base16'
  use {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require('mhennefarth.plugins.gruvbox')
    end,
  }

  -- A Better Status Line -- 
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('mhennefarth.plugins.lualine')
    end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- A better File System
  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('mhennefarth.plugins.tree')
    end,
  }

  -- Treesitter Syntax Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('mhennefarth.plugins.treesitter')
    end,
    run = ":TSUpdate",
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('mhennefarth.plugins.indent-blankline')
    end
  }


  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('mhennefarth.plugins.gitsigns')
    end
  }
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('mhennefarth.plugins.lspconfig')
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
	if packer_bootstrap then
		packer.sync()
	end
end)
