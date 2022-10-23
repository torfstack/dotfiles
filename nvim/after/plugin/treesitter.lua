require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "go", "lua" },
	auto_install = true,
	highlight = {
		enable = true,
	},
}

