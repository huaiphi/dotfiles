return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim"
        },
        lazy = true,
        init = function()
            require("telescope").load_extension("ui-select")
        end,
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                { "<leader>ff", builtin.find_files },
                { "<leader>fd", function()
                    builtin.find_files({
                        hidden = true,
                        no_ignore = true,
                    })
                end },
                { "<leader>fg", builtin.live_grep },
                { "<leader>fb", builtin.buffers },
                { "<leader>fs", builtin.lsp_document_symbols },
                { "<leader>fw", builtin.grep_string },
                { "<leader>fo", builtin.oldfiles },
                { "<leader>ft", builtin.diagnostics },
            }
        end,
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
        end,
    },
}
