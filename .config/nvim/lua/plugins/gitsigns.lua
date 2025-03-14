return {
    "lewis6991/gitsigns.nvim",
    opts = {},
    keys = function()
        local gs = require("gitsigns")
        return {
            { "<leader>hs", ":Gitsigns stage_hunk<CR>",                   mode = { "v", "n" } },
            { "<leader>hr", ":Gitsigns reset_hunk<CR>",                   mode = { "v", "n" } },
            { "<leader>hS", gs.stage_buffer },
            { "<leader>ha", gs.stage_hunk },
            { "<leader>hu", gs.undo_stage_hunk },
            { "<leader>hR", gs.reset_buffer },
            { "<leader>hp", gs.preview_hunk },
            { "<leader>hb", function() gs.blame_line({ full = true }) end },
            { "<leader>tB", gs.toggle_current_line_blame },
        }
    end,
    config = true
}
