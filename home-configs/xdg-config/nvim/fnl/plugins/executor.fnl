(local executor (require :executor))
(local utils (require :utils))

(λ configure []
  (executor.setup 
    {:split {:position :bottom
             :size (math.floor (/ vim.o.lines 4))}})
  (utils.nmap "<leader>r" (λ [] (vim.cmd :ExecutorRun)))
  (utils.nmap "<leader>d" (λ [] (vim.cmd :ExecutorToggleDetail))))
                   

{: configure}
