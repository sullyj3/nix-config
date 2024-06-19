; (local {: assoc} (require :nfnl.core))

(fn concat [...]
  "Concatenates the sequential table arguments together."
  (let [result []]
    (each [_ xs (ipairs [...])]
      (each [_ x (ipairs xs)]
        (table.insert result x)))
    result))

(λ map [mode lhs rhs ?opts]
  (let [default-opts {:noremap true :silent true}
        options (if ?opts (vim.tbl_extend :force default-opts ?opts) default-opts)]
    (vim.keymap.set mode lhs rhs options)))

(local nmap (partial map :n))

(λ buf_nmap [lhs rhs ?opts]
  (let [opts (or ?opts {})]
    (tset opts :buffer true)
    (nmap lhs rhs opts)))

{: map : nmap : buf_nmap : concat}
