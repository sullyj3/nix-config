-- [nfnl] Compiled from fnl/commands.fnl by https://github.com/Olical/nfnl, do not edit.
return vim.api.nvim_create_user_command("Cdhere", "cd %:p:h", {nargs = 0})
