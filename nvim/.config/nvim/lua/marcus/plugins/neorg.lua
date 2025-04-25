return {
	"nvim-neorg/neorg",
	dependencies = { "luarocks.nvim" },
	enabled = false,
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							bible = "~/notes/bible",
							cs = "~/notes/cs",
						},
					},
				},
			},
		})
	end,
}
