vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function (use)

    use 'wbthomason/packer.nvim'

    use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }})

    use { 'nvim-treesitter/nvim-treesitter-context' }

    use { 'nvim-treesitter/playground' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
            { "debugloop/telescope-undo.nvim" },
        },
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        }
    }

    use 'tpope/vim-fugitive'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
            { 'folke/neodev.nvim' },    -- Additional Lua configuration
        }
    }

    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons"
        }
    }

    use 'folke/tokyonight.nvim'

    use 'm4xshen/autoclose.nvim'

    use "lukas-reineke/indent-blankline.nvim"

    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }

    use 'Shatur/neovim-session-manager'

    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup()
        end,
    })

    use({
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {}
        end,
    })

    use "lewis6991/gitsigns.nvim"

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use 'nanozuki/tabby.nvim'

    use 'Civitasv/cmake-tools.nvim'

    use 'voldikss/vim-mma'

    use 'nvim-orgmode/orgmode'

    use({
        "unbleaklessness/ChatGPT.nvim",
        branch = "development",
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    })

    use 'Vimjas/vim-python-pep8-indent'
end)
