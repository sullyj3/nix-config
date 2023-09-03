-- [nfnl] Compiled from fnl/plugins/copilot.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local function _2_()
    local copilot = require("copilot")
    return copilot.setup({suggestion = {auto_trigger = true}})
  end
  return vim.defer_fn(_2_, 100)
end
return {configure = _1_}
