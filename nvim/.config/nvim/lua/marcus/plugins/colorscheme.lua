return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			background = {
				light = "frappe",
				dark = "mocha",
			},
			transparent_background = true,
			float = {
				transparent = false,
			},
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.10, -- percentage of the shade to apply to the inactive window
			},
			integrations = {
				cmp = true,
				nvimtree = true,
				telescope = true,
			},
		})

		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
