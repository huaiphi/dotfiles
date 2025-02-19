return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim"
        },
        lazy = false,
        keys = {
            { mode = "n", "<leader>ff" },
            { mode = "n", "<leader>fg" },
            { mode = "n", "<leader>fb" },
            { mode = "n", "<leader>fs" },
            { mode = "n", "<leader>xq" }
        },
        config = function()
            local builtin_actions = require("telescope.actions")
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown()
                    }
                },
                -- Default mapping
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--hidden",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    mappings = {
                        -- insert mode
                        i = {
                            -- ["<C-j>"] = builtin_actions.select_default,
                            ["<C-o>"] = builtin_actions.select_horizontal,
                        },
                        -- normal mode
                        n = {},
                    },
                },
            })
            require("telescope").load_extension("ui-select")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fd", function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
            vim.keymap.set("n", "<leader>ft", builtin.diagnostics, {})
        end,
    },
}
