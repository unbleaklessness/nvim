vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function (use)

    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} },
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = 'vim.cmd[[colorscheme rose-pine]]',
    })

    use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }})

    use 'tpope/vim-fugitive'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    use "williamboman/mason.nvim"

    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons"
        }
    }

    use 'folke/tokyonight.nvim'

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use 'm4xshen/autoclose.nvim'

    use 'nvim-treesitter/nvim-treesitter-context'
end)
