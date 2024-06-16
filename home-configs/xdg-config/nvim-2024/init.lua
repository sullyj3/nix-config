
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

-- Bootstap hotpot into lazy plugin dir if it does not exist yet.
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
end

vim.opt.rtp:prepend({hotpotpath, lazypath})

require "hotpot"

local plugins = {"rktjmp/hotpot.nvim"}
require("lazy").setup(plugins)

require "say-hello"
