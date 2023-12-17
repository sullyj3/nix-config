(local utils (require :utils))
(local {: nmap} utils)
(local telescope (require :telescope))
(local telescope-builtin (require :telescope.builtin))
(local telescope-actions (require :telescope.actions))

(λ configure []
  (telescope.setup 
    {:defaults {:mappings {:i {:<C-d> telescope-actions.delete_buffer
                               :<C-u> false}
                           :n {:<C-d> telescope-actions.delete_buffer}}
                :extensions {:file_browser {:hijack_netrw true}}}})
  (telescope.load_extension :file_browser)
  (nmap :<leader>b telescope-builtin.buffers)
  (nmap :<leader><space> #(telescope-builtin.find_files {:previewer false}))
  (nmap :<leader>sb telescope-builtin.current_buffer_fuzzy_find)
  (nmap :<leader>sh telescope-builtin.help_tags)
  (nmap :<leader>ss telescope-builtin.lsp_dynamic_workspace_symbols)
  (nmap :<leader>sd telescope-builtin.grep_string)
  (nmap :<leader>f telescope-builtin.live_grep)
  (nmap :<leader>so #(telescope-builtin.tags {:only_current_buffer true}))
  (nmap :<leader>m telescope-builtin.oldfiles))

{: configure}
