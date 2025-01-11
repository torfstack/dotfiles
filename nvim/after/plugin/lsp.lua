require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require('cmp')

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup{}
lspconfig.gopls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.helm_ls.setup{
    settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server",
            }
        }
    }
}

cmp.setup({
    completion = {
        autocomplete = false,
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between completion items
        ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ["<Tab>"] = cmp.mapping(function(fallback)
            local copilot = require 'copilot.suggestion'
            if copilot.is_visible() then
                copilot.accept()
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        {name = 'nvim_lsp'},
    },
})

