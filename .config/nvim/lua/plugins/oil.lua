return {
    "stevearc/oil.nvim",
    config = function()
        local oil = require("oil")
        vim.keymap.set("n", "-", "<CMD>Oil<CR>")
        oil.setup({})
    end
}
