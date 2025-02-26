return {
    {
        "saghen/blink.cmp",
        dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
        version = "*",
        lazy = true,
        event = "BufReadPost",
        opts = {
            signature = {
                enabled = true,
                trigger = {
                    show_on_insert = true,
                },
            },
            keymap = {
                preset = "default",
                ["<Tab>"] = {
                    function(cmp) cmp.show({}) end,
                },
                ["<C-space>"] = {}
            },
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            completion = {
                menu = {
                    draw = {
                        columns = { { 'kind' }, { 'label', 'label_description', gap = 1 } }
                    }
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            }
        },
        opts_extend = { "sources.default" },
    },
}
