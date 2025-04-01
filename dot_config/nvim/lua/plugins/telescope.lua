return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim"
    },
    lazy = true,
    init = function()
        require("telescope").load_extension("ui-select")
    end,
    opts = {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown()
            }
        },
    },
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
            { "<leader>gb", builtin.git_branches },
        }
    end,
    config = true,
}
