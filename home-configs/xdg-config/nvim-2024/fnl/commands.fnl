(λ cd-here []
  (vim.cmd.cd "%:p:h"))

(vim.api.nvim_create_user_command "Cdhere" cd-here { :nargs 0})
