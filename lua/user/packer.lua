local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    use({ "nvim-treesitter/nvim-treesitter-context" })

    use({ "nvim-treesitter/playground" })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        requires = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                -- run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                run = "make",
            },
            { "debugloop/telescope-undo.nvim" },
        },
    })

    use({
        "nvim-telescope/telescope-file-browser.nvim",
        requires = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
    })

    use("tpope/vim-fugitive")

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" }, -- Required
            { "folke/neodev.nvim" }, -- Additional Lua configuration
        },
    })

    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
    })

    use("folke/tokyonight.nvim")

    use("m4xshen/autoclose.nvim")

    use("lukas-reineke/indent-blankline.nvim")

    use({
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "rmagatti/auto-session",
    })

    use({
        "rmagatti/session-lens",
        requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    })

    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup()
        end,
    })

    use({ "Pocco81/auto-save.nvim" })

    use("lewis6991/gitsigns.nvim")

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })

    use("nanozuki/tabby.nvim")

    use({ "akinsho/toggleterm.nvim", tag = "*" })

    use({ "stevearc/overseer.nvim" })

    use("Civitasv/cmake-tools.nvim")

    use("voldikss/vim-mma")

    use("nvim-orgmode/orgmode")

    use({
        "unbleaklessness/ChatGPT.nvim",
        branch = "development",
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    })

    use("Vimjas/vim-python-pep8-indent")

    use("rcarriga/nvim-notify")

    use({
        "Vonr/align.nvim",
        branch = "v2",
    })

    -- use({ "xiyaowong/transparent.nvim" })

    use("danielo515/nvim-treesitter-reason")

    use({
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    })

    use({ "nvim-pack/nvim-spectre" })

    use({ "HiPhish/rainbow-delimiters.nvim" })

    -- use { "RRethy/vim-illuminate" }

    use({ "stevearc/conform.nvim" })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
