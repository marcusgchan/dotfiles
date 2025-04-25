return {
  "ThePrimeagen/harpoon", 
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<S-f>j", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<S-f>k", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<S-f>l", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<S-f>;", function() ui.nav_file(4) end)
  end,
}
