-- [nfnl] Compiled from fnl/plugins/copilot-cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local function configure()
  local copilot_cmp = require("copilot_cmp")
  return copilot_cmp.setup()
end
return {configure = configure}
