(λ cd-here []
  (vim.cmd.cd "%:p:h"))

(vim.api.nvim_create_user_command "Cdhere" cd-here { :nargs 0})

(local config-path "~/nix-config/home-configs/xdg-config/nvim")

(vim.api.nvim_create_user_command "Config" 
  (λ [] 
     (vim.cmd.edit (.. config-path "/fnl/options.fnl")) 
     (vim.cmd.cd config-path))
  { :nargs 0})
