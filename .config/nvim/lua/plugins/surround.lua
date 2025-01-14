return {
    "kylechui/nvim-surround",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end,
}
