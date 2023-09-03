-- TODO switch to fennel? see https://github.com/Olical/nfnl
-- TODO migrate to new style mappings (vim.keymap.set instead of vim.api.nvim_set_keymap)
--   - this allows providing lua functions as rhs instead of having write '<cmd>lua ...<CR>'
--   - probably best to setup a function which defaults to norermap and silent

-- Install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
		print("Cloning packer.nvim...")
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		print("Installing packer.nvim...")
    vim.cmd [[packadd packer.nvim]]
		print("Packer installed!")
    return true
  end
  return false
end

ensure_packer()

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require 'mappings'
require 'commands'

-- TODO extract to lua/plugins.lua
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
	use {
		'numToStr/Comment.nvim',
		config = function() require('Comment').setup() end
	}
  -- UI to select things (files, grep results, open buffers...)
  use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = require'plugins.telescope'.configure
	}
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
	-- Fancier statusline
  use {
		'itchyny/lightline.vim',
		after = 'everforest',
		config = require'plugins.lightline'.configure
	}
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = require'plugins.gitsigns'.configure
	}
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
		config = require'plugins.nvim-treesitter'.configure
	}
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
	-- Collection of configurations for built-in LSP client
  use {
		'neovim/nvim-lspconfig',
		-- after = { --[[ todo ]] },
		-- config = require'plugins.nvim-lspconfig'.configure
	}
	-- Autocompletion plugin
  use {
		'hrsh7th/nvim-cmp',
		config = require'plugins.nvim-cmp'.configure
	}
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- colors
  use 'jacoborus/tender.vim'
  use 'arcticicestudio/nord-vim'
  use 'sainnhe/everforest'

  -- # General utils --
  use 'vim-utils/vim-line'
  use 'tpope/vim-surround'
	-- vim-sneak replacement. Jump to character pairs, using hints only if 
	-- ambiguous
  use {
		'ggandor/leap.nvim',
		requires = { 'tpope/vim-repeat' },
		config = require'plugins.leap'.configure
	}
	-- f/t for leap.nvim
  use {
		'ggandor/flit.nvim',
		requires = { 'ggandor/leap.nvim' },
		after = { 'leap.nvim' },
		config = require'plugins.flit'.configure
	}
  use 'wellle/targets.vim'
  use 'alvan/vim-closetag'
  use 'whatyouhide/vim-textobj-xmlattr'
  use 'kana/vim-textobj-user'
  use 'iamcco/markdown-preview.nvim'
  use 'dominikduda/vim_current_word'
	-- Display current location in buffer in statusline or winbar
	use {
		'SmiteshP/nvim-navic',
		requires = "neovim/nvim-lspconfig",
		config = require'plugins.nvim-navic'.configure
	}
	-- Popup window for navigating buffer
  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",        -- Optional
        "nvim-telescope/telescope.nvim" -- Optional
		},
	}
	use {
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = require'plugins.copilot'.configure,
	}
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = require'plugins.copilot-cmp'.configure,
	}
  -- Live html preview
  use { 'turbio/bracey.vim', run = 'npm install --prefix server' }
  -- Session manager
  use 'tpope/vim-obsession'

  -- Languages
  use {
		'evanleck/vim-svelte',
		config = require'plugins.vim-svelte'.configure
	}
  use 'purescript-contrib/purescript-vim'
  use 'LnL7/vim-nix'
  use 'khaveesh/vim-fish-syntax'
  use 'habamax/vim-godot'
  use 'ziglang/zig.vim'
  use {
		'mlochbaum/BQN',
		rtp = 'editors/vim',
		config = require'plugins.bqn'.configure
	}
  use 'https://git.sr.ht/~detegr/nvim-bqn'
  use 'sj2tpgk/vim-oil'
	use 'bakpakin/janet.vim'

	use "gpanders/nvim-parinfer"
	use "tpope/vim-repeat"

end)

require 'options'

-- TODO disentangle and extract to modules
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
