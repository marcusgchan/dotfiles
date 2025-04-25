return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-y>"] = "select_default",
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fi", function()
			builtin.find_files({
				no_ignore = true,
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			})
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fcb", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>fds", builtin.lsp_document_symbols, {})
		vim.keymap.set("n", "<leader>fn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, {})
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
	end,
}
