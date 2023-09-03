local M = {}
local utils = require 'utils'

M.configure = function()
	local telescope = require 'telescope'
	telescope.setup {
		extensions = {
			file_browser = {
				hijack_netrw = true,
			},
		},
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
		},
	}
	telescope.load_extension "file_browser"

	local telescope_builtin = require 'telescope.builtin'

	utils.nmap('<leader>b', telescope_builtin.buffers)
	utils.nmap('<leader><space>', function() telescope_builtin.find_files { previewer = false } end)
	utils.nmap('<leader>sb', telescope_builtin.current_buffer_fuzzy_find)
	utils.nmap('<leader>sh', telescope_builtin.help_tags)
	utils.nmap('<leader>ss', telescope_builtin.lsp_dynamic_workspace_symbols)
	utils.nmap('<leader>sd', telescope_builtin.grep_string)
	utils.nmap('<leader>f', telescope_builtin.live_grep)
	utils.nmap('<leader>so', function() telescope_builtin.tags { only_current_buffer = true } end)
	utils.nmap('<leader>m', telescope_builtin.oldfiles)
end

return M
