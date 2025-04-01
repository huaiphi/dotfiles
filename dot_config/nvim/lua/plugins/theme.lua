return {
    "wtfox/jellybeans.nvim",
    priority = 1000,
    config = function()
        require("jellybeans").setup({
            italics = false,
            flat_ui = false,
        })
        vim.cmd.colorscheme("jellybeans")
    end,
}
