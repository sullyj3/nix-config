-- [nfnl] Compiled from fnl/plugins/Comment-nvim.fnl by https://github.com/Olical/nfnl, do not edit.
local comment_nvim = require("Comment")
local function configure()
  return comment_nvim.setup()
end
return {configure = configure}
