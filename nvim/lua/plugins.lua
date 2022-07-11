local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- general
  use 'AndrewRadev/splitjoin.vim'
  use 'ludovicchabant/vim-gutentags'
  use 'alvan/vim-closetag'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-surround'
  use 'ruanyl/vim-gh-line'
  use 'nvim-lualine/lualine.nvim'

  -- sql
  use 'shmup/vim-sql-syntax'

  -- ruby
  use 'vim-ruby/vim-ruby'
  use 'tpope/vim-rails'
  use 'RRethy/nvim-treesitter-endwise'

  -- golang
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

  -- crystal
  -- Plug 'vim-crystal/vim-crystal'
  -- Plug 'jlcrochet/vim-crystal'
  -- Plug 'will/tree-sitter-crystal'

  -- tree sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  -- telescope
  -- dependencies
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  -- telescope itself
  use 'nvim-telescope/telescope.nvim'

  -- language server
  use 'neovim/nvim-lspconfig'

  use 'ap/vim-css-color'

  -- autocomplete
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/vim-vsnip-integ'
  use 'L3MON4D3/LuaSnip'

  -- themes
  use 'sainnhe/everforest'

  -- copilot
  -- Plug 'github/copilot.vim'
  --
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
   require('packer').sync()
  end
end)
