require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "python",
        "rust",
        "typescript",
        "yaml",
    },
	auto_install = true,
	highlight = {
		enable = true,
        additional_vim_regex_highlighting = false,
	},
    incremental_selection = {
        enable = true,
    },
	indent = {
		enable = true,
	},
}

