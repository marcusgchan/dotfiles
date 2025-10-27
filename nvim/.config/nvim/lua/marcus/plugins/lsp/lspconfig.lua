return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		local opts = { noremap = true }
		local global_on_attach = function(client, bufnr)
			opts.buffer = bufnr

			keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			keymap.set("n", "K", vim.lsp.buf.hover, opts)
			keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
			keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
			keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = 1 })
			end, opts)
			keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = -1 })
			end, opts)
			keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
			keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
			keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
			keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			cmp_nvim_lsp.default_capabilities(),
			{
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}
		)

		-- Global LSP configuration
		vim.lsp.config('*', {
			on_attach = global_on_attach,
			capabilities = capabilities,
		})

		-- HTML LSP
		vim.lsp.config('html', {
			filetypes = { "html", "templ" },
		})
		vim.lsp.enable('html')

		-- TypeScript LSP
		vim.lsp.config('ts_ls', {})
		vim.lsp.enable('ts_ls')

		-- Svelte LSP
		vim.lsp.config('svelte', {
			on_attach = function(client, bufnr)
				-- run the existing default (if set)
				local prev = (vim.lsp.config['svelte'] or {}).on_attach
				if prev then
					prev(client, bufnr)
				end

				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})
		vim.lsp.enable('svelte')

		-- CSS LSP
		vim.lsp.config('cssls', {})
		vim.lsp.enable('cssls')

		-- Tailwind CSS LSP
		vim.lsp.config('tailwindcss', {
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
		vim.lsp.enable('tailwindcss')

		-- Prisma LSP
		vim.lsp.config('prismals', {})
		vim.lsp.enable('prismals')

		-- Pyright LSP
		vim.lsp.config('pyright', {
			pyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Ignore all files for analysis to exclusively use Ruff for linting
					ignore = { "*" },
				},
			},
		})
		vim.lsp.enable('pyright')

		-- Ruff LSP
		vim.lsp.config('ruff', {})
		vim.lsp.enable('ruff')

		-- Clangd LSP
		vim.lsp.config('clangd', {})
		vim.lsp.enable('clangd')

		-- CMake LSP
		vim.lsp.config('cmake', {})
		vim.lsp.enable('cmake')

		-- Go LSP
		vim.lsp.config('gopls', {
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
		vim.lsp.enable('gopls')

		-- Templ LSP
		vim.lsp.config('templ', {})
		vim.lsp.enable('templ')

		-- Luau LSP
		vim.lsp.config('luau_lsp', {})
		vim.lsp.enable('luau_lsp')

		-- Java LSP
		vim.lsp.config('jdtls', {})
		vim.lsp.enable('jdtls')

		-- Lua LSP
		vim.lsp.config('lua_ls', {
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
		vim.lsp.enable('lua_ls')
	end,
}
