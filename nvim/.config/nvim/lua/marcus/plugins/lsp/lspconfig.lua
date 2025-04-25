return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local opts = { noremap = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			keymap.set("n", "K", vim.lsp.buf.hover, opts)
			keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
			keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
			keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
			keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
			keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
			keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
			keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
			keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig.util.default_config.capabilities,
			cmp_nvim_lsp.default_capabilities(),
			{
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}
		)

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "templ" },
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure svelte server
		-- https://github.com/sveltejs/language-tools/issues/2008
		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"html",
				"css",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
				"templ",
			},
			init_options = { userLanguages = { templ = "html" } },
		})

		lspconfig["prismals"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["cmake"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		lspconfig["templ"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
			end,
		})

		lspconfig["luau_lsp"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
			end,
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
