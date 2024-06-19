(local lazy (require :lazy))

(λ config-module [module-path]
  (λ [] (let [mod (require (.. :plugin-config. module-path))]
             (mod.configure))))

(local plugins 
  [
    :rktjmp/hotpot.nvim
    :tpope/vim-surround
    :atweiden/vim-fennel
    { 1   :gpanders/nvim-parinfer
      :ft [:fennel :scheme :clojure :racket :dune]}
    :LnL7/vim-nix
    { 1             :nvim-telescope/telescope.nvim
      :tag          :0.1.6
      :dependencies [:nvim-lua/plenary.nvim]
      :config       (config-module :telescope)}
    :tpope/vim-repeat
    { 1             :ggandor/leap.nvim
      :dependencies [:tpope/vim-repeat]
      :config       true}
    { 1             :ggandor/flit.nvim
      :dependencies [:ggandor/leap.nvim]
      :config       true}
    { 1       :hrsh7th/nvim-cmp
      :config (config-module :nvim-cmp)}
    :hrsh7th/cmp-nvim-lsp
    { 1             :neovim/nvim-lspconfig
      :dependencies [:cmp-nvim-lsp]
      :config       (config-module :nvim-lspconfig)}
    { 1             :SmiteshP/nvim-navic 
      :dependencies [ :neovim/nvim-lspconfig]}
    { 1             :SmiteshP/nvim-navbuddy 
      :dependencies [ :neovim/nvim-lspconfig
                      :SmiteshP/nvim-navic
                      :MunifTanjim/nui.nvim
                      :nvim-telescope/telescope.nvim]}]) 
                     
(lazy.setup plugins)
