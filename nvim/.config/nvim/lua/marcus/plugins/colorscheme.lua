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
				transparent = true,
			},
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
		})

		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
