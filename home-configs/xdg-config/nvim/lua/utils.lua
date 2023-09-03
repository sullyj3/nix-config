local M = {}
function M.map(mode, lhs, rhs, opts)
	local default_opts = {noremap = true, silent = true}
	local options
	if opts then
		options = vim.tbl_extend("force", default_opts, opts)
	else
		options = default_opts
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

function M.nmap(lhs, rhs, opts)
	M.map('n', lhs, rhs, opts)
end
return M
