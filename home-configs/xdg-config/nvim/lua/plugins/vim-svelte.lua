-- [nfnl] Compiled from fnl/plugins/vim-svelte.fnl by https://github.com/Olical/nfnl, do not edit.
local function configure()
  vim.g.svelte_preprocessors = {"typescript"}
  return nil
end
return {configure = configure}
