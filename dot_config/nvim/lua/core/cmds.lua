local user_cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd

user_cmd("CopyBufferPath", "let @+ = expand('%:p')", {})

autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("text_yank_post", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch" })
    end,
})

vim.api.nvim_create_augroup("tab", { clear = true })

autocmd("FileType", {
    group = "tab",
    pattern = "make",
    callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.expandtab = false
    end,
})

autocmd("FileType", {
    group = "tab",
    pattern = {
        "html",
        "css",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "json",
        "toml",
        "yaml",
    },
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 4
        vim.opt.expandtab = true
    end,
})

autocmd("DirChanged", {
    callback = function()
        local cwd = vim.fn.getcwd()
        local hostname = vim.fn.hostname()
        os.execute('printf "\\033]7;file://' .. hostname .. cwd .. '\\033\\\\"')
    end,
})
