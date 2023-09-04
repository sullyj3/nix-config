
(λ configure []
   (set vim.g.lightline 
        {:colorscheme :everforest
         :active {:left [[:mode :paste] [:gitbranch :readonly :filename :modified]]}
         :component_function {:gitbranch :fugitive#head}}))

{: configure}
