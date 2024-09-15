return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.2",
		opts = {
			auto_install = true,
			ensure_installed = {
				"javascript",
				"ruby",
				"typescript",
				"css",
				"gitignore",
				"http",
				"json",
				"scss",
				"sql",
				"vim",
				"lua",
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
		},
	},
}
