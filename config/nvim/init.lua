-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- --
  -- End kickstart
  -- --
  -- colors
  use 'jacoborus/tender.vim'
  use 'arcticicestudio/nord-vim'
  use 'sainnhe/everforest'

  -- # General utils --
  use 'vim-utils/vim-line'
  use 'tpope/vim-surround'
  -- use 'justinmk/vim-sneak'
  use 'ggandor/leap.nvim'
  use 'ggandor/flit.nvim'
  use 'wellle/targets.vim'
  use 'alvan/vim-closetag'
  use 'whatyouhide/vim-textobj-xmlattr'
  use 'kana/vim-textobj-user'
  use 'iamcco/markdown-preview.nvim'
  use 'dominikduda/vim_current_word'

	use {
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require('copilot').setup {
					suggestion = { auto_trigger = true }
				}
			end, 100)
		end,
	}
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function ()
			require("copilot_cmp").setup()
		end
	}
  -- Live html preview
  use { 'turbio/bracey.vim', run = 'npm install --prefix server' }
  -- Session manager
  use 'tpope/vim-obsession'

  -- Languages
  use 'evanleck/vim-svelte'
  use 'purescript-contrib/purescript-vim'
  use 'LnL7/vim-nix'
  use 'khaveesh/vim-fish-syntax'
  use { 'unisonweb/unison', branch = 'trunk', rtp = 'editor-support/vim' }
  use 'habamax/vim-godot'
  use 'ziglang/zig.vim'
  use { 'mlochbaum/BQN', rtp = 'editors/vim' }
  use 'https://git.sr.ht/~detegr/nvim-bqn'
  use 'sj2tpgk/vim-oil'
	use 'bakpakin/janet.vim'

  use "b0o/mapx.nvim"
	use "gpanders/nvim-parinfer"

end)

vim.filetype.add({ extension = { bqn = 'bqn' } })

if vim.g.neovide ~= nil then
  vim.o.guifont = 'DejaVuSansMono Nerd font:h6.7'
  vim.g.neovide_scroll_animation_length = 0.5
end

-- Case insensitive file tab completion in command line mode
vim.o.wildignorecase = true

--Set highlight on search
vim.o.hlsearch = true

-- TODO disabling temporarily since it causes a segfault (https://github.com/neovim/neovim/issues/20316)
-- vim.o.cmdheight = 0

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Wrapped lines start at same indentation
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end
-- vim.g.onedark_terminal_italics = 2
-- vim.cmd [[colorscheme tender]]
-- vim.cmd [[colorscheme nord]]

vim.g.everforest_background = 'hard'

vim.cmd [[colorscheme everforest]]

--Set statusbar
vim.g.lightline = {
  colorscheme = 'everforest',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require("telescope").setup {
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
require("telescope").load_extension "file_browser"
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

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so',
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format {async = true}' ]]

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
      formattingProvider = "stylish-haskell",
      checkParents = "AlwaysCheck"
    }
  }
}

local other_servers = { 'html', 'cssls', 'rust_analyzer', 'jedi_language_server' }
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

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-------------------
-- End Kickstart --
-------------------

-- vim-svelte
vim.g.svelte_preprocessors = { 'typescript' }

vim.cmd [[ command! Cdhere cd %:p:h]]

-- vim-sneak
-- vim.cmd [[map f <Plug>Sneak_f]]
-- vim.cmd [[map F <Plug>Sneak_F]]
-- vim.cmd [[map t <Plug>Sneak_t]]
-- vim.cmd [[map T <Plug>Sneak_T]]
require('leap').add_default_mappings()
require('flit').setup()

vim.o.cursorline = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
