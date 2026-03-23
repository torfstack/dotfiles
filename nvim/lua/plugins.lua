-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    -- Go
    { 'ray-x/go.nvim', lazy = false },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            -- New nvim-treesitter rewrite: highlighting and indentation are
            -- handled natively by neovim. setup() only accepts install_dir.
            require('nvim-treesitter').setup()
        end,
    },

    -- Git
    { 'airblade/vim-gitgutter', lazy = false },
    { 'tpope/vim-fugitive', lazy = false },

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Helm templates
    { 'towolf/vim-helm', lazy = false },

    -- LSP
    { 'neovim/nvim-lspconfig', lazy = false },
    { 'williamboman/mason.nvim', lazy = false },
    { 'williamboman/mason-lspconfig.nvim', lazy = false },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp', lazy = false },
    { 'hrsh7th/cmp-buffer', lazy = false },
    { 'hrsh7th/cmp-path', lazy = false },
    { 'hrsh7th/cmp-nvim-lsp', lazy = false },
    { 'hrsh7th/cmp-nvim-lua', lazy = false },

    -- Snippets (required for LSP snippet expansion)
    {
        'L3MON4D3/LuaSnip',
        lazy = false,
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
                    keymap = { accept = "<C-i>" },
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
    { 'ayu-theme/ayu-vim', lazy = false, priority = 1000 },
})
