return {
	-- Mason and LSP Setup
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		opts = function(_, opts)
			require("mason").setup() -- Basic Mason setup

			local mason_lspconfig = require("mason-lspconfig")

			-- Install LSP servers via mason-lspconfig
			mason_lspconfig.setup({
				ensure_installed = {
					"tailwindcss",
					"html",
					"lua_ls",
					"eslint",
					"solargraph",
					"stylelint_lsp",
					"rubocop",
				},
				automatic_installation = true, -- Automatically install missing servers
			})

			local lspconfig = require("lspconfig")

			-- LazyVim manages capabilities setup already, so we'll just use those
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if has_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			mason_lspconfig.setup_handlers({
				-- Default handler for all servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["stylelint_lsp"] = function()
					lspconfig.stylelint_lsp.setup({
						capabilities = capabilities,
						filetypes = { "css", "scss" },
					})
				end,

				["tailwindcss"] = function()
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						root_dir = function(...)
							return require("lspconfig.util").root_pattern(".git")(...)
						end,
					})
				end,

				["ts_ls"] = function()
					lspconfig.tsserver.setup({
						capabilities = capabilities,
					})
				end,

				["html"] = function()
					lspconfig.html.setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								completion = {
									workspaceWord = true,
									callSnippet = "Both",
								},
								hint = {
									enable = true,
									paramType = true,
								},
								format = {
									enable = false,
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
										continuation_indent_size = "2",
									},
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		opts = {
			suggestion = {
				enabled = false,
			},
			panel = { enabled = false },
		},
	},
}
