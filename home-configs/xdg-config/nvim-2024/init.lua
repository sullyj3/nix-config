
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- Bootstrap hotpot (fennel compiler)
local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
if not vim.loop.fs_stat(hotpotpath) then
	vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"--branch=v0.12.0",
		"https://github.com/rktjmp/hotpot.nvim.git",
		hotpotpath,
	})
	vim.notify("Bootstrapping hotpot.nvim... Done", vim.log.levels.INFO)
end

vim.opt.rtp:prepend({hotpotpath, lazypath})

-- This allows us to write the rest of our config in fennel
require 'hotpot'

-- Setting <leader>, which occurs in 'mappings' needs to come before any 
-- <leader> mappings in plugin configurations
require 'mappings'
require 'plugins'
