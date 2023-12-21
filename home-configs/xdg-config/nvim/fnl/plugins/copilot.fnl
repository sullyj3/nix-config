{ :configure
 (λ []
    (vim.defer_fn 
      (λ [] (let [copilot (require :copilot)] 
                 (copilot.setup { :suggestion { :auto_trigger true
                                                :keymap { :accept_line "<M-k>"
                                                          :accept_word "<M-j>"}}})))
      100))}



