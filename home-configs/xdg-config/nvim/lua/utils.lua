-- [nfnl] Compiled from fnl/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.core")
local assoc = _local_1_["assoc"]
local function map(mode, lhs, rhs, _3fopts)
  _G.assert((nil ~= rhs), "Missing argument rhs on /home/james/nix-config/home-configs/xdg-config/nvim/fnl/utils.fnl:3")
  _G.assert((nil ~= lhs), "Missing argument lhs on /home/james/nix-config/home-configs/xdg-config/nvim/fnl/utils.fnl:3")
  _G.assert((nil ~= mode), "Missing argument mode on /home/james/nix-config/home-configs/xdg-config/nvim/fnl/utils.fnl:3")
  local default_opts = {noremap = true, silent = true}
  local options
  if _3fopts then
    options = vim.tbl_extend("force", default_opts, _3fopts)
  else
    options = default_opts
  end
  return vim.keymap.set(mode, lhs, rhs, options)
end
local nmap
local function _3_(...)
  return map("n", ...)
end
nmap = _3_
local function buf_nmap(lhs, rhs, _3fopts)
  _G.assert((nil ~= rhs), "Missing argument rhs on /home/james/nix-config/home-configs/xdg-config/nvim/fnl/utils.fnl:9")
  _G.assert((nil ~= lhs), "Missing argument lhs on /home/james/nix-config/home-configs/xdg-config/nvim/fnl/utils.fnl:9")
  local opts = assoc((_3fopts or {}), "buffer", true)
  return nmap(lhs, rhs, opts)
end
return {map = map, nmap = nmap, buf_nmap = buf_nmap}
