
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
  use 'RRethy/nvim-base16'

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
