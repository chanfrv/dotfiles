vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- package manager
    use('wbthomason/packer.nvim') 
    -- Plenary
    use('nvim-lua/plenary.nvim')
    -- Configurations for Nvim LSP
    use('neovim/nvim-lspconfig')
    -- better highlight
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    -- Filetree
    use('nvim-telescope/telescope.nvim')
    -- colorscheme
    use('navarasu/onedark.nvim')
    -- Lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- Indent line
    use('lukas-reineke/indent-blankline.nvim')
end)
