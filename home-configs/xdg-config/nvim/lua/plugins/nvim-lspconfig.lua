local M = {}
function M.configure()

	-- TODO rename
	local nvim_lsp = require 'lspconfig'
	local on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		local opts = { noremap = true, silent = true }

		-- attach navic and navbuddy
		if client.server_capabilities.documentSymbolProvider then
			require('nvim-navic').attach(client, bufnr)
			vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

			require('nvim-navbuddy').attach(client, bufnr)
			vim.keymap.set('n', '<leader>n', '<cmd>Navbuddy<CR>', vim.tbl_extend("force", opts, { buffer = true }))
		end

		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
			'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d',
			[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
		vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format {async = true}' ]]

		-- TODO factor out all map helpers
		local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local cmd = vim.api.nvim_command

		if client.server_capabilities.codeLensProvider then
			map("n", "<leader>l", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
			cmd [[augroup LspCodelensAutoGroup]]
			cmd [[au!]]
			cmd [[au BufEnter <buffer> lua vim.lsp.codelens.refresh()]]
			cmd [[au CursorHold <buffer> lua vim.lsp.codelens.refresh()]]
			cmd [[au InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
			cmd [[augroup end]]
		else
			print('no')
		end
	end

	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	-- Enable the following language servers
	-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
	-- local servers = { 'hls', 'pyright', 'tsserver' }

	nvim_lsp['hls'].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			haskell = {
				formattingProvider = "fourmolu",
				checkParents = "AlwaysCheck"
			}
		}
	}

	local other_servers = { 'html', 'cssls', 'rust_analyzer', 'jedi_language_server', 'gdscript' }
	for _, lsp in ipairs(other_servers) do
		nvim_lsp[lsp].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end

	-- Make runtime files discoverable to the server
	local runtime_path = vim.split(package.path, ';')
	table.insert(runtime_path, 'lua/?.lua')
	table.insert(runtime_path, 'lua/?/init.lua')

	require('lspconfig').lua_ls.setup {
		-- cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim' },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file('', true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	}
end
return M
