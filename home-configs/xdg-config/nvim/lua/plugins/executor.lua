-- [nfnl] Compiled from fnl/plugins/executor.fnl by https://github.com/Olical/nfnl, do not edit.
local executor = require("executor")
local utils = require("utils")
local function configure()
  executor.setup({split = {position = "bottom", size = math.floor((vim.o.lines / 4))}})
  local function _1_()
    return vim.cmd("ExecutorRun")
  end
  utils.nmap("<leader>r", _1_)
  local function _2_()
    return vim.cmd("ExecutorToggleDetail")
  end
  return utils.nmap("<leader>d", _2_)
end
return {configure = configure}
