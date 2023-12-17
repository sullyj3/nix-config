-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local utils = require("utils")
local _local_1_ = utils
local nmap = _local_1_["nmap"]
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")
local function configure()
  telescope.setup({defaults = {mappings = {i = {["<C-d>"] = telescope_actions.delete_buffer, ["<C-u>"] = false}, n = {["<C-d>"] = telescope_actions.delete_buffer}}, extensions = {file_browser = {hijack_netrw = true}}}})
  telescope.load_extension("file_browser")
  nmap("<leader>b", telescope_builtin.buffers)
  local function _2_()
    return telescope_builtin.find_files({previewer = false})
  end
  nmap("<leader><space>", _2_)
  nmap("<leader>sb", telescope_builtin.current_buffer_fuzzy_find)
  nmap("<leader>sh", telescope_builtin.help_tags)
  nmap("<leader>ss", telescope_builtin.lsp_dynamic_workspace_symbols)
  nmap("<leader>sd", telescope_builtin.grep_string)
  nmap("<leader>f", telescope_builtin.live_grep)
  local function _3_()
    return telescope_builtin.tags({only_current_buffer = true})
  end
  nmap("<leader>so", _3_)
  return nmap("<leader>m", telescope_builtin.oldfiles)
end
return {configure = configure}
