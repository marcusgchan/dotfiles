require("marcus.core.options")
require("marcus.core.keymaps")
require("marcus.filetypes")

local venv = os.getenv("VIRTUAL_ENV")
if venv then
	vim.g.python3_host_prog = venv .. "/bin/python"
else
	vim.g.python3_host_prog = "~/.pyenv/shims/python"
end
-- vim.g.python3_host_prog = venv .. "/bin/python"
