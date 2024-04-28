-- [nfnl] Compiled from fnl/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local utils = require("utils")
utils.map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
utils.nmap("k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
utils.nmap("j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
utils.nmap("<leader><tab>", ":bnext<CR>")
return utils.nmap("<leader>v", "\"+p")
