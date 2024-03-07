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

-- TODO I think with home-manager this won't work. Need an alternative. Could 
-- try using home.activation to run `nvim -c PackerCompile`. Maybe ask in the nix discourse
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

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
		config = function() require'plugins.telescope'.configure() end
	}
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
	-- Fancier statusline
  use {
		'itchyny/lightline.vim',
		after = 'everforest',
		config = function() require'plugins.lightline'.configure() end
	}
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function() require'plugins.gitsigns'.configure() end
	}
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
		config = function() require'plugins.nvim-treesitter'.configure() end
	}
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
	-- Collection of configurations for built-in LSP client
  use {
		'neovim/nvim-lspconfig',
		after = { 'nvim-navic', 'nvim-navbuddy', 'telescope.nvim', 'cmp-nvim-lsp', "lean.nvim" },
		config = function() require'plugins.nvim-lspconfig'.configure() end
	}
	-- Autocompletion plugin
  use {
		'hrsh7th/nvim-cmp',
		config = function() require'plugins.nvim-cmp'.configure() end
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
		config = function() require'plugins.leap'.configure() end
	}
	-- f/t for leap.nvim
  use {
		'ggandor/flit.nvim',
		requires = { 'ggandor/leap.nvim' },
		after = { 'leap.nvim' },
		config = function() require'plugins.flit'.configure() end
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
		config = function() require'plugins.nvim-navic'.configure() end
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
		config = function() require'plugins.copilot'.configure() end
	}
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function() require'plugins.copilot-cmp'.configure() end
	}
  -- Live html preview
  use { 'turbio/bracey.vim', run = 'npm install --prefix server' }
  -- Session manager
  use 'tpope/vim-obsession'

	-- Fancy UI
	use {
		'folke/noice.nvim',
		requires = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
		config = function() require'plugins.noice'.configure() end
	}

  -- Languages
	use 'Julian/lean.nvim'
	-- fennel
	use "Olical/nfnl"
  use {
		'evanleck/vim-svelte',
		config = function() require'plugins.vim-svelte'.configure() end
	}
  use 'purescript-contrib/purescript-vim'
  use 'LnL7/vim-nix'
  use 'khaveesh/vim-fish-syntax'
  use 'habamax/vim-godot'
  use 'ziglang/zig.vim'
  use {
		'mlochbaum/BQN',
		rtp = 'editors/vim',
		config = function() require'plugins.bqn'.configure() end
	}
  use 'https://git.sr.ht/~detegr/nvim-bqn'
  use 'sj2tpgk/vim-oil'
	use 'bakpakin/janet.vim'

	use "gpanders/nvim-parinfer"
	use "tpope/vim-repeat"

	use "tikhomirov/vim-glsl"

	use {
		'google/executor.nvim',
		requires = { 'MunifTanjim/nui.nvim' },
		config = function() require'plugins.executor'.configure() end
	}

end)

vim.filetype.add { extension = { an = 'ante' } }
