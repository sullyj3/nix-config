; (local luasnip (require :luasnip))
(local cmp (require :cmp))

(λ configure []
  (cmp.setup 
    {:mapping {:<C-Space> (cmp.mapping.complete)
               :<C-d> (cmp.mapping.scroll_docs (- 4))
               :<C-e> (cmp.mapping.close)
               :<C-f> (cmp.mapping.scroll_docs 4)
               :<C-n> (cmp.mapping.select_next_item)
               :<C-p> (cmp.mapping.select_prev_item)
               :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                           :select true})}}))
               ; :<Tab> (fn [fallback]
               ;          (if (cmp.visible) (cmp.select_next_item)
               ;              (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
               ;              (fallback)))
               ; :<S-Tab> (fn [fallback]
               ;            (if (cmp.visible) (cmp.select_prev_item)
               ;                (luasnip.jumpable (- 1)) (luasnip.jump (- 1))
               ;                (fallback)))
               

     ; :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
     ; :sources [{:name :nvim_lsp} {:name :luasnip}]}))

{: configure}
