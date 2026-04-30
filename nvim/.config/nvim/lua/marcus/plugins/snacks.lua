return {
	{
		"folke/snacks.nvim",
		opts = {
			rename = { enabled = true },
		},
		keys = {
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
		},
	},
}
