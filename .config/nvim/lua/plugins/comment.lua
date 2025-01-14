return {
    "numToStr/Comment.nvim",
    lazy = true,
    keys = {
        { "gcc", mode = "n" },
        { "gc",  mode = "v" },
    },
    config = function()
        require("Comment").setup()
    end
}
