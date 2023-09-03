local M = {}
function M.configure()
	vim.filetype.add({ extension = { bqn = 'bqn' } })
end
return M
