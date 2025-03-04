return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = function()
        local neogit = require("neogit")
        return {
            { "<leader>gs", function() neogit.open({ kind = "floating" }) end },
            { "<leader>gc", function() neogit.open({ "commit" }) end },
            { "<leader>gp", function() neogit.open({ "pull" }) end },
            { "<leader>gP", function() neogit.open({ "push" }) end },
        }
    end
}
