(local utils (require :utils))
(local {: nmap} utils)
(local telescope (require :telescope))
(local telescope-builtin (require :telescope.builtin))
(local telescope-actions (require :telescope.actions))

(λ configure []
  (telescope.setup 
    {:defaults {:mappings {:i {:<C-d> telescope-actions.delete_buffer
                               :<C-u> false}
                           :n {:<C-d> telescope-actions.delete_buffer}}}})
  (nmap :<leader><space> #(telescope-builtin.find_files {:previewer false}))
  (nmap :<leader>b telescope-builtin.buffers)
  (nmap :<leader>g telescope-builtin.live_grep)
  (nmap :<leader>m telescope-builtin.oldfiles))

{: configure}
