(local lazy (require :lazy))

(λ config-module [module-path]
  (λ [] (let [mod (require (.. :plugin-config. module-path))]
             (mod.configure))))

(λ configure-lean []
  (let [lspconfig    (require :plugin-config.nvim-lspconfig)
        cmp-nvim-lsp (require :cmp_nvim_lsp)
        lean         (require :lean)
        capabilities (cmp-nvim-lsp.default_capabilities)]
       (lean.setup { :lsp {: capabilities
                           :on_attach lspconfig.on-attach}
                     :mappings true})))

(local plugins
  [
    ; editing utils
    :tpope/vim-surround
    :tpope/vim-repeat

    ; motions
    { 1             :ggandor/leap.nvim
      :dependencies [:tpope/vim-repeat]
      :config       true}
    { 1             :ggandor/flit.nvim
      :dependencies [:ggandor/leap.nvim]
      :config       true}

    ; ui
    ; { 1             :lewis6991/gitsigns.nvim
    ;   :dependencies [:nvim-lua/plenary.nvim]
    ;   :config       true}

    ; complicated utils
    { 1       :hrsh7th/nvim-cmp
      :event  :InsertEnter
      :config (config-module :nvim-cmp)}
    :hrsh7th/cmp-nvim-lsp
    { 1             :nvim-telescope/telescope.nvim
      :tag          :0.1.6
      :dependencies [:nvim-lua/plenary.nvim]
      :config       (config-module :telescope)}
    { 1             :neovim/nvim-lspconfig
      :dependencies [:cmp-nvim-lsp]
      :config       (config-module :nvim-lspconfig)}
    { 1             :SmiteshP/nvim-navic
      :event        :LspAttach
      :dependencies [ :neovim/nvim-lspconfig]}
    { 1             :SmiteshP/nvim-navbuddy
      :event        :LspAttach
      :dependencies [ :neovim/nvim-lspconfig
                      :SmiteshP/nvim-navic
                      :MunifTanjim/nui.nvim
                      :nvim-telescope/telescope.nvim]}
    { 1 :zbirenbaum/copilot.lua
      :config (config-module :copilot)}

    ; languages
    :LnL7/vim-nix
    { 1       :Julian/lean.nvim
      :ft     :lean
      :config configure-lean}
    ; lisps
    { 1   :gpanders/nvim-parinfer
      :ft [:fennel :scheme :clojure :racket :dune]}
    :rktjmp/hotpot.nvim
    { 1   :atweiden/vim-fennel
      :ft :fennel}])

(lazy.setup plugins)
