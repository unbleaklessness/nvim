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

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        build = "make",
    },

    {
        "debugloop/telescope-undo.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
    },

    -- LSP.
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "zapling/mason-conform.nvim",
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    "L3MON4D3/LuaSnip",

    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {
            overrides = { buftype = { ["nofile"] = { enabled = false } } },
        },
    },

    -- {
    --     "VonHeikemen/lsp-zero.nvim",
    --     version = "v2.x",
    --     dependencies = {
    --         -- LSP Support
    --         { "neovim/nvim-lspconfig" },             -- Required
    --         { "williamboman/mason.nvim" },           -- Optional
    --         { "williamboman/mason-lspconfig.nvim" }, -- Optional
    --         { "zapling/mason-conform.nvim" },        -- Optional
    --         {
    --             "hrsh7th/nvim-cmp",
    --             opts = function(_, options)
    --                 options.sources = options.sources or {}
    --                 table.insert(options.sources, {
    --                     name = "lazydev",
    --                     group_index = 0,
    --                 })
    --             end,
    --         },                          -- Autocompletion
    --         { "hrsh7th/cmp-nvim-lsp" }, -- Required
    --         { "L3MON4D3/LuaSnip" },     -- Required
    --         {
    --             "folke/lazydev.nvim",
    --             ft = "lua",
    --             opts = {
    --                 library = {
    --                     { path = "luvit-meta/library", words = { "vim%.uv" } },
    --                 },
    --             },
    --         },
    --     },
    -- },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },

    -- "folke/tokyonight.nvim",

    -- "m4xshen/autoclose.nvim",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        -- config = true,
        -- opts = {
        --     disabled_filetype = {
        --         "TelescopePrompt",
        --         "chatgpt-input",
        --         "off",
        --     },
        -- },
    },

    "lukas-reineke/indent-blankline.nvim",

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
    },

    {
        "rmagatti/auto-session",
        lazy = false,
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    "okuuva/auto-save.nvim",

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

    -- "Vimjas/vim-python-pep8-indent",

    -- "rcarriga/nvim-notify",

    {
        "Vonr/align.nvim",
        branch = "v2",
        lazy = true,
    },

    "xiyaowong/transparent.nvim",

    -- "danielo515/nvim-treesitter-reason",

    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    -- },

    "nvim-pack/nvim-spectre",

    "HiPhish/rainbow-delimiters.nvim",

    "stevearc/conform.nvim",

    "robitx/gp.nvim",

    -- "sainnhe/gruvbox-material",

    -- "lambdalisue/vim-suda",

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require("blame").setup()
        end,
    },
}

require("lazy").setup(plugins, {})
