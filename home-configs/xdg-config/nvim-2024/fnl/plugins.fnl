(local lazy (require :lazy))

(λ config-fn [module-path]
  (λ [] (let [mod (require module-path)]
             (mod.configure))))

(local plugins [
                 :rktjmp/hotpot.nvim
                 :atweiden/vim-fennel
                 { 1   :gpanders/nvim-parinfer
                   :ft [:fennel :scheme :clojure :racket :dune]}
                 :LnL7/vim-nix
                 { 1             :nvim-telescope/telescope.nvim
                   :tag          :0.1.6
                   :dependencies [:nvim-lua/plenary.nvim]
                   :config       (config-fn :plugins/telescope)}])

(lazy.setup plugins)
