return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "pyright",
                "rust_analyzer",
                "ts_ls",
                "biome",
                "lua_ls",
                "jdtls",
                "gopls",
            },
        },
        config = true
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        opts = {
            autoformat = false,
            servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "-header-insertion=never",
                    },
                },
                pyright = {},
                rust_analyzer = {},
                ts_ls = {},
                lua_ls = {},
                jdtls = {},
                gopls = {},
                svelte = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local map_opts =
                    { silent = true, noremap = true, buffer = ev.buf }
                    vim.keymap.set(
                        "n",
                        "<leader>gD",
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
                end,
            })
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(
                    config.capabilities
                )
                lspconfig[server].setup(config)
            end
        end,
    },
}
