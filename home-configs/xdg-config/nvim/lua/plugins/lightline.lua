-- [nfnl] Compiled from fnl/plugins/lightline.fnl by https://github.com/Olical/nfnl, do not edit.
local function configure()
  vim.g.lightline = {colorscheme = "everforest", active = {left = {{"mode", "paste"}, {"gitbranch", "readonly", "filename", "modified"}}}, component_function = {gitbranch = "fugitive#head"}}
  return nil
end
return {configure = configure}
