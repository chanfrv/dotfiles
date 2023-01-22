vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'
    -- Plenary
    use 'nvim-lua/plenary.nvim'
    -- Auto config install
    use  'williamboman/mason.nvim'
    -- Auto LSP config
    use 'williamboman/mason-lspconfig.nvim'
    -- Configurations for Nvim LSP
    use 'neovim/nvim-lspconfig'
    -- Autocomplete
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    --
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    -- better highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- Filetree
    use 'nvim-telescope/telescope.nvim'
    -- colorscheme
    use 'navarasu/onedark.nvim'
    -- Lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- Indent line
    use 'lukas-reineke/indent-blankline.nvim'
    -- Harpoon
    use 'ThePrimeagen/harpoon'
end)
