local map = vim.keymap
local opts = { silent = true, noremap = true }

map.set("n", "<leader>d", function()
    if #vim.api.nvim_list_wins() == 1 then
        vim.cmd("DelBuf")
    else
        local win_height =
            vim.api.nvim_win_get_height(vim.api.nvim_get_current_win())
        vim.cmd("bp | sp | bn | bd")
        vim.cmd("res " .. win_height)
    end
end, opts)

map.set("i", "<C-c>", "<ESC>", opts)
