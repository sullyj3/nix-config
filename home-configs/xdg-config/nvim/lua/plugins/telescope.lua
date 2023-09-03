local M = {}

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
	--Add leader shortcuts
	vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader><space>',
		[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]]
		, { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>so',
		[[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>m', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
		{ noremap = true, silent = true })
end

return M
