return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"c",
			"cpp",
			"cmake",
			"lua",
			"vimdoc",
			"javascript",
			"typescript",
			"tsx",
			"sql",
			"html",
			"css",
			"dockerfile",
			"json",
			"prisma",
			"svelte",
			"templ",
			"python",
			"markdown",
			"markdown_inline",
			"hcl",
			"java",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				-- Safely start Treesitter highlighting
				if lang and pcall(vim.treesitter.start, args.buf, lang) then
					-- Enable Treesitter indentation (disabled for typescript/tsx)
					if not vim.tbl_contains({ "typescript", "tsx" }, args.match) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end
			end,
		})
	end,
}
