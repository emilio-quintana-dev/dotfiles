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
					"stylelint_lsp",
				},
				-- automatic_installation = true, -- Automatically install missing servers
			})

			local lspconfig = require("lspconfig")

			-- LazyVim manages capabilities setup already, so we'll just use those
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if has_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			-- Directly set up non-Mason servers first
			lspconfig.rubocop.setup({
				capabilities = capabilities,
				cmd = { os.getenv("HOME") .. "/.asdf/shims/rubocop", "--lsp" },
				root_dir = require("lspconfig.util").root_pattern("Gemfile", ".rubocop.yml", ".git", "."),
				filetypes = { "ruby" },
			})

			lspconfig.solargraph.setup({
				capabilities = capabilities,
				cmd = { os.getenv("HOME") .. "/.asdf/shims/solargraph", "stdio" },
				root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git", "."),
				filetypes = { "ruby" },
				settings = {
					solargraph = {
						autoformat = true,
						completion = true,
						diagnostic = true,
						folding = true,
						references = true,
						rename = true,
						symbols = true,
					},
				},
			})

			-- Set up Mason servers
			mason_lspconfig.setup_handlers({
				-- Default handler for all servers
				function(server_name)
					-- Skip servers that have custom configs below
					if server_name ~= "solargraph" and server_name ~= "rubocop" then
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end
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

				-- Removed individual handlers for solargraph and rubocop
				-- since they're set up directly before the handlers

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
				enabled = true,
			},
			panel = { enabled = true },
		},
	},
}
