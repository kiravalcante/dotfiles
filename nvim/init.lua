-- =========================
-- Opções básicas
-- =========================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.mouse = "a"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true

-- =========================
-- Atalhos básicos
-- =========================

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Salvar" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Sair" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- =========================
-- lazy.nvim
-- =========================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- Tokyo Night
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
            })

            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files,
                { desc = "Buscar arquivos" })

            vim.keymap.set("n", "<leader>fg", builtin.live_grep,
                { desc = "Buscar texto" })

            vim.keymap.set("n", "<leader>fb", builtin.buffers,
                { desc = "Buscar buffers" })

            vim.keymap.set("n", "<leader>fh", builtin.help_tags,
                { desc = "Buscar ajuda" })
        end,
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },

    -- LSP
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    {
        "neovim/nvim-lspconfig",
    },

    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "clangd",
                "pyright",
                "ts_ls",
            },
        },
    },

    -- Autocomplete
    {
        "saghen/blink.cmp",
        version = "1.*",

        opts = {
            keymap = {
                preset = "default",
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },
        },

        opts_extend = {
            "sources.default",
        },
    },

    -- Formatação
    {
        "stevearc/conform.nvim",

        opts = {
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },

                python = {
                    "black",
                },

                javascript = {
                    "prettier",
                },

                typescript = {
                    "prettier",
                },

                javascriptreact = {
                    "prettier",
                },

                typescriptreact = {
                    "prettier",
                },

                sql = {
                    "sql_formatter",
                },
            },

            format_on_save = {
                timeout_ms = 1000,
                lsp_format = "fallback",
            },
        },
    },

})
