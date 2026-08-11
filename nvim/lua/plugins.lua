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

            local installed = treesitter.get_installed('parsers')
            local missing = vim.tbl_filter(function(parser)
                return not vim.list_contains(installed, parser)
            end, parsers)
            if #missing > 0 then
                treesitter.install(missing)
            end

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
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            vim.lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(),
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
        'saghen/blink.cmp',
        branch = 'main', -- v2; lazy-lock.json pins the exact commit
        dependencies = {
            'saghen/blink.lib',
            'L3MON4D3/LuaSnip',
            'folke/lazydev.nvim',
        },
        build = function()
            require('blink.cmp').build():pwait()
        end,
        opts = {
            snippets = { preset = 'luasnip' },
            keymap = {
                preset = 'default',
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                ['<Tab>'] = {
                    function()
                        local suggestion = require('copilot.suggestion')
                        if suggestion.is_visible() then
                            suggestion.accept()
                            return true
                        end
                        return false
                    end,
                    'select_next',
                    'snippet_forward',
                    'fallback',
                },
            },
            completion = {
                -- Preserve the previous manual <C-Space> completion behavior.
                menu = { auto_show = false },
                documentation = { auto_show = false },
            },
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                },
            },
            fuzzy = { implementation = 'rust' },
        },
    },

    -- Snippets (required for LSP snippet expansion)
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        build = 'make install_jsregexp',
    },

    -- Copilot
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 15,
                    trigger_on_accept = true,
                    -- <Tab> is handled by Blink above so it can fall back to
                    -- completion, snippet navigation, and finally a literal tab.
                    keymap = { accept = false },
                },
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'BlinkCmpMenuOpen',
                callback = function()
                    vim.b.copilot_suggestion_hidden = true
                end,
            })
            vim.api.nvim_create_autocmd('User', {
                pattern = 'BlinkCmpMenuClose',
                callback = function()
                    vim.b.copilot_suggestion_hidden = false
                end,
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
