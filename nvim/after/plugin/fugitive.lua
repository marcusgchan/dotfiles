vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>p", function() vim.cmd.Git("push") end)
vim.keymap.set("n", "<leader>pa", function() vim.cmd.Git("push -u origin") end)
