; (local {: assoc} (require :nfnl.core))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions from nfnl.core ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fn nil? [x]
  "True if the value is equal to Lua `nil`."
  (= nil x))

(fn even? [n]
  "True if `n` is even."
  (= (% n 2) 0))

(fn odd? [n]
  "True if `n` is odd."
  (not (even? n)))

(fn table? [x]
  "True if the value is of type 'table'."
  (= "table" (type x)))

(fn keys [t]
  "Get all keys of a table."
  (let [result []]
    (when t
      (each [k _ (pairs t)]
        (table.insert result k)))
    result))

(fn count [xs]
  "Count the items / characters in the input. Can handle tables, nil, strings and anything else that works with `(length xs)`."
  (if
    (table? xs) (let [maxn (table.maxn xs)]
                  ;; We only count the keys if maxn returns 0.
                  (if (= 0 maxn)
                    (table.maxn (keys xs))
                    maxn))
    (not xs) 0
    (length xs)))

(fn run! [f xs]
  "Execute the function (for side effects) for every xs."
  (when xs
    (let [nxs (count xs)]
      (when (> nxs 0)
        (for [i 1 nxs]
          (f (. xs i)))))))

; this seems overcomplicated to me... why not just use (each)?

(fn concat [...]
  "Concatenates the sequential table arguments together."
  (let [result []]
    (run! (fn [xs]
            (run!
              (fn [x]
                (table.insert result x))
              xs))
          [...])
    result))

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

{: map : nmap : buf_nmap : concat}
