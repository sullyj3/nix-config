{ :configure
 (λ []
    (vim.defer_fn 
      (λ [] (let [copilot (require :copilot)] 
                 (copilot.setup { :suggestion { :auto_trigger true }})))
      100))}



