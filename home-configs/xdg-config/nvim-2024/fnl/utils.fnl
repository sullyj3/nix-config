; (local {: assoc} (require :nfnl.core))

; from https://github.com/Olical/nfnl/blob/7614d666eaea1674dc96184e0e3c1a8bc2c4a3b2/fnl/nfnl/core.fnl#L333
(fn assoc [t ...]
  "Set the key `k` in table `t` to the value `v` while safely handling `nil`.

   Accepts more `k` and `v` pairs as after the initial pair. This allows you
   to assoc multiple values in one call.

   Returns the table `t` once it has been mutated."
  (let [[k v & xs] [...]
        rem (count xs)
        t (or t {})]

    (when (odd? rem)
      (error "assoc expects even number of arguments after table, found odd number"))

    (when (not (nil? k))
      (tset t k v))

    (when (> rem 0)
      (assoc t (unpack xs)))

    t))

(λ map [mode lhs rhs ?opts]
  (let [default-opts {:noremap true :silent true}
        options (if ?opts (vim.tbl_extend :force default-opts ?opts) default-opts)]
    (vim.keymap.set mode lhs rhs options)))

(local nmap (partial map :n))
(λ buf_nmap [lhs rhs ?opts]
  (let [opts (assoc (or ?opts {}) :buffer true)]
    (nmap lhs rhs opts)))

{: map : nmap : buf_nmap}
