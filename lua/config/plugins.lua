local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    local repository = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repository, lazy_path })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone `lazy.nvim`:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazy_path)

local plugins = {
    "wbthomason/packer.nvim",

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    "nvim-treesitter/nvim-treesitter-context",

    "nvim-treesitter/playground",

    {
        "nvim-telescope/telescope.nvim",
        -- version = "0.1.6",
        version = "0.1.6",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                build = "make",
            },
            { "debugloop/telescope-undo.nvim" },
        },
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
    },

    "tpope/vim-fugitive",

    {
        "VonHeikemen/lsp-zero.nvim",
        version = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                dependencies = {
                    { "williamboman/mason.nvim" }, -- Optional
                    { "williamboman/mason-lspconfig.nvim" }, -- Optional
                },
            },
            -- Autocompletion
            {
                "hrsh7th/nvim-cmp",
                opts = function(_, options)
                    options.sources = options.sources or {}
                    table.insert(options.sources, {
                        name = "lazydev",
                        group_index = 0,
                    })
                end,
            }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" }, -- Required
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "luvit-meta/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },

    "folke/tokyonight.nvim",

    "m4xshen/autoclose.nvim",

    "lukas-reineke/indent-blankline.nvim",

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "rmagatti/session-lens",
        dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    "Pocco81/auto-save.nvim",

    "lewis6991/gitsigns.nvim",

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    },

    "nanozuki/tabby.nvim",

    "akinsho/toggleterm.nvim",

    -- "stevearc/overseer.nvim",

    "Civitasv/cmake-tools.nvim",

    "voldikss/vim-mma",

    -- "nvim-orgmode/orgmode",

    -- {
    --     "unbleaklessness/ChatGPT.nvim",
    --     version = "development",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    -- },

    "Vimjas/vim-python-pep8-indent",

    "rcarriga/nvim-notify",

    {
        "Vonr/align.nvim",
        branch = "v2",
    },

    -- "xiyaowong/transparent.nvim",

    "danielo515/nvim-treesitter-reason",

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    "nvim-pack/nvim-spectre",

    "HiPhish/rainbow-delimiters.nvim",

    -- "RRethy/vim-illuminate",

    "stevearc/conform.nvim",

    "robitx/gp.nvim",
}

local options = {}

require("lazy").setup(plugins, options)

