local map = vim.keymap
local opts = { silent = true, noremap = true }

map.set("n", "<C-O>", "<Nop>", opts)
map.set("n", "<C-I>", "<Nop>", opts)
map.set({ "n", "i" }, "<C-Space>", "<Nop>", opts)

map.set("n", "<leader>h", "<CMD>noh<CR>", opts)

map.set("n", "<leader>z", "<CMD>DelBuf<CR>", opts)
map.set("n", "<leader>w", "<CMD>bw<CR>", opts)
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

map.set("n", "[q", "<CMD>cnext<CR>")
map.set("n", "]q", "<CMD>cprevious<CR>")
map.set("n", "[Q", "<CMD>cfirst<CR>")
map.set("n", "]Q", "<CMD>clast<CR>")

map.set("i", "<C-c>", "<ESC>", opts)
