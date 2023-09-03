local utils = require 'utils'

local function on_attach(client, bufnr)
	vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

	-- attach navic and navbuddy
	if client.server_capabilities.documentSymbolProvider then
		require('nvim-navic').attach(client, bufnr)
		vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

		require('nvim-navbuddy').attach(client, bufnr)
		utils.buf_nmap('<leader>n', vim.cmd.Navbuddy)
	end

	utils.buf_nmap('gD', vim.lsp.buf.declaration)
	utils.buf_nmap('gd', vim.lsp.buf.definition)
	utils.buf_nmap('K', vim.lsp.buf.hover)
	utils.buf_nmap('gi', vim.lsp.buf.implementation)
	utils.buf_nmap('<C-k>', vim.lsp.buf.signature_help)
	utils.buf_nmap('<leader>wa', vim.lsp.buf.add_workspace_folder)
	utils.buf_nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder)
	utils.buf_nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
	utils.buf_nmap('<leader>D', vim.lsp.buf.type_definition)
	utils.buf_nmap('<leader>rn', vim.lsp.buf.rename)
	utils.buf_nmap('gr', vim.lsp.buf.references)
	utils.buf_nmap('<leader>ca', vim.lsp.buf.code_action)
	utils.buf_nmap('<leader>e', vim.diagnostic.open_float)
	utils.buf_nmap('[d', vim.diagnostic.goto_prev)
	utils.buf_nmap(']d', vim.diagnostic.goto_next)
	utils.buf_nmap('<leader>q', vim.diagnostic.setloclist)
	utils.buf_nmap('<leader>d', require('telescope.builtin').lsp_document_symbols)

	vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format { async = true } end)

	if client.server_capabilities.codeLensProvider then
		utils.buf_nmap('<leader>l', vim.lsp.codelens.run)
		vim.cmd [[augroup LspCodelensAutoGroup]]
		vim.cmd [[au!]]
		vim.cmd [[au BufEnter <buffer> lua vim.lsp.codelens.refresh()]]
		vim.cmd [[au CursorHold <buffer> lua vim.lsp.codelens.refresh()]]
		vim.cmd [[au InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
		vim.cmd [[augroup end]]
	else
		print('CodeLens not supported by language server')
	end
end

local M = {}
function M.configure()
	local lspconfig = require 'lspconfig'
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	lspconfig.hls.setup {
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
		lspconfig[lsp].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end

	-- Make runtime files discoverable to the server
	local runtime_path = vim.split(package.path, ';')
	table.insert(runtime_path, 'lua/?.lua')
	table.insert(runtime_path, 'lua/?/init.lua')

	lspconfig.lua_ls.setup {
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

	-- fennel
	lspconfig.fennel_language_server.setup {
		on_attach = on_attach,
		capabilities = capabilities,
		-- source code resides in directory `fnl/`
		root_dir = lspconfig.util.root_pattern("fnl"),
		settings = {
			fennel = {
				workspace = {
					-- If you are using hotpot.nvim or aniseed,
					-- make the server aware of neovim runtime files.
					library = vim.api.nvim_list_runtime_paths(),
				},
				diagnostics = {
					globals = {'vim'},
				},
			},
		},
	}

end

return M
