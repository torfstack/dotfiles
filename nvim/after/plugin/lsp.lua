require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"lua_ls", "gopls", "rust_analyzer", "helm_ls", "vtsls", "pyright"},
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local cmp = require('cmp')
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

require('go').setup({
    lsp_cfg = false,
    lsp_gofumpt = false,
    lsp_on_attach = true,
    auto_format = true,
    auto_lint = false,
    lsp_inlay_hints = { enable = false },
})
