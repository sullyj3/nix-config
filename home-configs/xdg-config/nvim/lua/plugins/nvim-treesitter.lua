-- [nfnl] Compiled from fnl/plugins/nvim-treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local treesitter_configs = require("nvim-treesitter.configs")
local function configure()
  return treesitter_configs.setup({highlight = {enable = true}, incremental_selection = {enable = true, keymaps = {node_incremental = "grn", scope_incremental = "grc", node_decremental = "grm"}}, indent = {enable = true}, textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner"}}}, move = {enable = true, set_jumps = true, goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"}, goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"}, goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"}, goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}}})
end
return {configure = configure}
