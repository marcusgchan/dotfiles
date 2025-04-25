return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local masonLspConfig = require("mason-lspconfig")

		mason.setup({})

		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
				"clang-format",
			},
		})

		masonLspConfig.setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"prismals",
				"pyright",
				"gopls",
				"templ",
				"clangd",
				"cmake",
			},
			automatic_installation = true,
		})

		-- masonLspConfig.setup_handlers({
		-- 	-- Will be called for each installed server that doesn't have
		-- 	-- a dedicated handler.
		-- 	--
		-- 	function(server_name) -- default handler (optional)
		-- 		-- https://github.com/neovim/nvim-lspconfig/pull/3232
		-- 		if server_name == "tsserver" then
		-- 			server_name = "ts_ls"
		-- 		end
		-- 		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- 		require("lspconfig")[server_name].setup({
		--
		-- 			capabilities = capabilities,
		-- 		})
		-- 	end,
		-- })
	end,
}
