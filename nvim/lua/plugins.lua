-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'ayu',
                section_separators = { left = '', right = '' },
                component_separators = '',
            },
        },
    },

    -- Go
    {
        'ray-x/go.nvim',
        ft = { 'go', 'gomod', 'gowork', 'gotmpl' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'neovim/nvim-lspconfig',
        },
        opts = {
            lsp_cfg = false,
            lsp_gofumpt = false,
            auto_format = true,
            auto_lint = false,
            lsp_inlay_hints = { enable = false },
        },
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local treesitter = require('nvim-treesitter')
            local parsers = {
                'go',
                'gomod',
                'gosum',
                'gotmpl',
                'gowork',
                'javascript',
                'json',
                'lua',
                'python',
                'rust',
                'tsx',
                'typescript',
                'yaml',
            }

            treesitter.setup()
            treesitter.install(parsers)

            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'go',
                    'gomod',
                    'gowork',
                    'gotmpl',
                    'javascript',
                    'javascriptreact',
                    'json',
                    'lua',
                    'python',
                    'rust',
                    'typescript',
                    'typescriptreact',
                    'yaml',
                },
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })

            local function enable_helm_syntax()
                if vim.bo.filetype ~= 'helm' then
                    return
                end

                vim.treesitter.stop()
                vim.cmd.syntax('enable')
                vim.cmd('setlocal syntax=helm')
            end

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'helm',
                callback = enable_helm_syntax,
            })

            vim.api.nvim_create_autocmd('BufWinEnter', {
                pattern = '*',
                callback = enable_helm_syntax,
            })
        end,
    },

    -- Git
    { 'airblade/vim-gitgutter', lazy = false },
    { 'tpope/vim-fugitive', lazy = false },

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        keys = {
            { 'ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
            { 'fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
            { 'fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
            { 'fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        },
    },

    -- Helm templates
    { 'towolf/vim-helm', lazy = false },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            vim.lsp.config('*', {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
        end,
    },
    { 'williamboman/mason.nvim', lazy = false, opts = {} },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
            ensure_installed = {
                'lua_ls',
                'gopls',
                'rust_analyzer',
                'helm_ls',
                'vtsls',
                'pyright',
            },
            automatic_enable = {
                'lua_ls',
                'gopls',
                'rust_analyzer',
                'helm_ls',
                'vtsls',
                'pyright',
            },
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    autocomplete = false,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        local copilot = require('copilot.suggestion')
                        if copilot.is_visible() then
                            copilot.accept()
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'lazydev', group_index = 0 },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                }),
            })
        end,
    },
    { 'hrsh7th/cmp-buffer', lazy = true },
    { 'hrsh7th/cmp-path', lazy = true },
    { 'hrsh7th/cmp-nvim-lsp', lazy = false },

    -- Snippets (required for LSP snippet expansion)
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        build = 'make install_jsregexp',
        dependencies = { 'saadparwaiz1/cmp_luasnip' },
    },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = { accept = false },
                },
            })
        end,
    },

    -- Neovim API completions and type hints in config files
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {},
    },

    -- Colors
    {
        'ayu-theme/ayu-vim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true
            vim.o.background = 'dark'
            vim.cmd.colorscheme('ayu')
            vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        end,
    },
}, {
    rocks = {
        enabled = false,
    },
})
