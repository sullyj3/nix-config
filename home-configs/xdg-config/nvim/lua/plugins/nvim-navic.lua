-- [nfnl] Compiled from fnl/plugins/nvim-navic.fnl by https://github.com/Olical/nfnl, do not edit.
local nvim_navic = require("nvim-navic")
local function configure()
  return nvim_navic.setup({click = true})
end
return {configure = configure}
