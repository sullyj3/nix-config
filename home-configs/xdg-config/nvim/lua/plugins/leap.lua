-- [nfnl] Compiled from fnl/plugins/leap.fnl by https://github.com/Olical/nfnl, do not edit.
local function configure()
  local leap = require("leap")
  return leap.add_default_mappings()
end
return {configure = configure}
