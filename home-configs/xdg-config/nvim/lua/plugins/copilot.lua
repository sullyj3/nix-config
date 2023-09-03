local M = {}
function M.configure()
	vim.defer_fn(function()
		require('copilot').setup {
			suggestion = { auto_trigger = true }
		}
		end, 100)
end
return M
