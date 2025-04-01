return {
    "kylechui/nvim-surround",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    version = "*",
    lazy = true,
    event = "BufReadPost",
    opts = {},
    config = true
}
