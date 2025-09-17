return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		mason.setup({})

		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			ensure_installed = {
				-- Formatters and linters
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"eslint_d", -- js linter
				"clang-format",
				-- LSP servers (installed but not auto-configured)
				"typescript-language-server", -- ts_ls
				"html-lsp", -- html
				"css-lsp", -- cssls
				"tailwindcss-language-server", -- tailwindcss
				"lua-language-server", -- lua_ls
				"prisma-language-server", -- prismals
				"ruff", -- ruff (same name)
				"gopls", -- gopls (same name)
				"templ", -- templ (same name)
				"clangd", -- clangd (same name)
				"pyright", -- pyright (same name)
				"cmake-language-server", -- cmake
			},
		})
	end,
}
