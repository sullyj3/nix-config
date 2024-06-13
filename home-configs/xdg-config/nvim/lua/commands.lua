-- [nfnl] Compiled from fnl/commands.fnl by https://github.com/Olical/nfnl, do not edit.
local function cd_here()
  return vim.cmd.cd("%:p:h")
end
vim.api.nvim_create_user_command("Cdhere", cd_here, {nargs = 0})
local config_path = "~/nix-config/home-configs/xdg-config/nvim"
local function _1_()
  vim.cmd.edit((config_path .. "/fnl/options.fnl"))
  return vim.cmd.cd(config_path)
end
return vim.api.nvim_create_user_command("Config", _1_, {nargs = 0})
