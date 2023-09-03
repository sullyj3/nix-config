-- [nfnl] Compiled from fnl/plugins/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local gitsigns = require("gitsigns")
local utils = require("utils")
local gs = package.loaded.gitsigns
local function on_attach()
  local function _1_()
    if vim.wo.diff then
      return "]c"
    else
      vim.schedule(gs.next_hunk)
      return "<Ignore>"
    end
  end
  utils.buf_nmap("]c", _1_, {expr = true})
  local function _3_()
    if vim.wo.diff then
      return "[c"
    else
      vim.schedule(gs.prev_hunk)
      return "<Ignore>"
    end
  end
  return utils.buf_nmap("[c", _3_, {expr = true})
end
local signs = {add = {hl = "GitGutterAdd", text = "+", change = {hl = "GitGutterChange", text = "~"}, delete = {hl = "GitGutterDelete", text = "_"}, topdelete = {hl = "GitGutterDelete", text = "\226\128\190"}, changedelete = {hl = "GitGutterChange", text = "~"}}}
local function configure()
  return gitsigns.setup({signs = signs, on_attach = on_attach})
end
return {configure = configure}
