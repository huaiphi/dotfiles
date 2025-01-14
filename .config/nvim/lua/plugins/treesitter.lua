return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        vim.cmd("TSUpdate")
    end,
    config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.c3 = {
            install_info = {
                url = "https://github.com/c3lang/tree-sitter-c3",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "main",
            },
        }
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "comment",
                "lua",
                "c",
                "cpp",
                "cmake",
                "make",
                "vimdoc",
                "json",
                "markdown",
                "markdown_inline",
                "javascript",
                "typescript",
                "rust",
                "python",
                "vimdoc",
                "tsx",
                "json",
                "html",
                "css",
                "go",
                "markdown",
                "markdown_inline",
                "commonlisp",
                "zig",
                "bash",
                "prisma",
            },
            auto_install = true,
            endwise = { enable = true },
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        })
    end,
}
