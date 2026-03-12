local opt = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap

g.mapleader = ","
g.maplocalleader = ","
g.t_co = 256
g.background = "dark"
g.loaded_netrw = 1
map.set("i", "<C-c>", "<ESC>", { silent = true, noremap = true })

opt.splitright = true;
opt.splitbelow = true;

opt.mouse = "a"

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.signcolumn = "yes"
opt.showmode = false

opt.colorcolumn = "80"

opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.syntax = "on"
opt.termguicolors = true

opt.ignorecase = true
opt.hlsearch = true

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block"

autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("text_yank_post", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch" })
    end,
})

vim.api.nvim_create_augroup("tab", { clear = true })

autocmd("FileType", {
    group = "tab",
    pattern = "make",
    callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.expandtab = false
    end,
})

autocmd("FileType", {
    group = "tab",
    pattern = {
        "html",
        "css",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "json",
        "toml",
        "yaml",
    },
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 4
        vim.opt.expandtab = true
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "wtfox/jellybeans.nvim",
        priority = 1000,
        config = function()
            require("jellybeans").setup({
                italics = false,
                flat_ui = false,
            })
            vim.cmd("colorscheme jellybeans")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = { left = "|", right = '|' },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_c = { { 'filename', path = 1 } },
            },
        },
        config = true
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "comment",
                "lua",
                "c",
                "cpp",
                "cmake",
                "make",
                "go",
                "vimdoc",
                "json",
                "javascript",
                "typescript",
                "rust",
                "python",
                "vimdoc",
                "meson",
                "typst",
            },
            auto_install = true,
            endwise = { enable = true },
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        "mason-org/mason.nvim",
        config = true
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim"
        },
        opts = {
            ensure_installed = {
                "clangd",
                "rust_analyzer",
                "lua_ls",
                "gopls",
                "ty",
                "ruff",
            },
        },
        config = true
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("*", {})
            -- vim.lsp.set_log_level("off")
            vim.lsp.config.clangd = {
                cmd = {
                    "clangd",
                    "-header-insertion=never"
                }
            }
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    vim.diagnostic.config({ virtual_text = true })
                    local map_opts =
                    { silent = true, noremap = true, buffer = ev.buf }
                    vim.keymap.set(
                        "n", "<leader>gD",
                        vim.lsp.buf.declaration,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>gd",
                        vim.lsp.buf.definition,
                        map_opts
                    )
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, map_opts)
                    vim.keymap.set(
                        "n",
                        "<leader>gi",
                        vim.lsp.buf.implementation,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>k",
                        vim.lsp.buf.signature_help,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>wa",
                        vim.lsp.buf.add_workspace_folder,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>wr",
                        vim.lsp.buf.remove_workspace_folder,
                        map_opts
                    )
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, map_opts)
                    vim.keymap.set(
                        "n",
                        "<leader>D",
                        vim.lsp.buf.type_definition,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>rn",
                        vim.lsp.buf.rename,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>xq",
                        vim.lsp.buf.code_action,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>gr",
                        vim.lsp.buf.references,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>xx",
                        vim.diagnostic.open_float,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>dn",
                        vim.diagnostic.goto_next,
                        map_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>dp",
                        vim.diagnostic.goto_prev,
                        map_opts
                    )
                end,
            })
        end
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        version = "*",
        lazy = true,
        event = "InsertEnter",
        opts = {
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            sources = {
                default = { "lsp", "path" },
            },
            completion = {
                ghost_text = {
                    enabled = true,
                },
                menu = {
                    draw = {
                        columns = { { 'kind' }, { 'label', 'label_description', gap = 1 } }
                    },
                },
            },
        },
        opts_extend = { "sources.default" },
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            handler_opts = {
                border = "none",
            },
            timer_interval = 50,
            hint_prefix = "🐰 ",
        },
        config = true,
    },
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = { "BufWritePre" },
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>gf",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "n"
            }
        },
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt" },
                go = { "gofmt", "goimports" },
                c = { "clang-format" },
                cpp = { "clang-format" },
            }
        },
        config = true,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim", lazy = true },
        lazy = true,
        keys = {
            { "<leader>a", mode = "n" },
            { "<leader>e", mode = "n" },
            { "<C-p>",     mode = "n" },
            { "<C-n>",     mode = "n" }
        },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
        end
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "sindrets/diffview.nvim", opts = { use_icons = false } },
            "ibhagwan/fzf-lua",
        },
        cmd = "Neogit",
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        keys = {
            { "<leader>ff", mode = "n" },
            { "<leader>fg", mode = "n" },
            { "<leader>fb", mode = "n" },
            { "<leader>ft", mode = "n" },
            { "<leader>fT", mode = "n" },
            { "<leader>fs", mode = "n" },
        },
        opts = {},
        config = function(_, opts)
            local fzf = require("fzf-lua")
            fzf.setup(opts)
            vim.keymap.set("n", "<leader>ff", function() fzf.files() end)
            vim.keymap.set("n", "<leader>fg", function() fzf.live_grep() end)
            vim.keymap.set("n", "<leader>fb", function() fzf.buffers() end)
            vim.keymap.set("n", "<leader>fT", function() fzf.diagnostics_document() end)
            vim.keymap.set("n", "<leader>ft", function() fzf.diagnostics_workspace() end)
            vim.keymap.set("n", "<leader>fs", function() fzf.lsp_document_symbols() end)
        end,
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        opts = {},
        keys = {
            { "-", "<cmd>Oil<cr>", mode = "n" }
        },
        config = true,
    },
})
