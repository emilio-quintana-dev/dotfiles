if vim.loader then
	vim.loader.enable()
end

_G.print = vim.api.nvim_out_write

require("config.lazy")
