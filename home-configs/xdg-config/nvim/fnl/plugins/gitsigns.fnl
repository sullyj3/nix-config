(local gitsigns (require :gitsigns))
(local utils (require :utils))
(local gs package.loaded.gitsigns)

(λ on_attach []
  ; Navigation
  (utils.buf_nmap 
    "]c"
    (λ [] (if vim.wo.diff "]c" (do (vim.schedule gs.next_hunk)
                                   :<Ignore>)))
    {:expr true})
  (utils.buf_nmap 
    "[c"
    (λ [] (if vim.wo.diff "[c" (do (vim.schedule gs.prev_hunk)
                                   :<Ignore>)))
    {:expr true}))

; TODO figure out what all this shit does and whether it's compatible with
; jutjutsu's stageless paradigm
; -- Actions
; map('n', '<leader>hs', gs.stage_hunk)
; map('n', '<leader>hr', gs.reset_hunk)
; map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
; map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
; map('n', '<leader>hS', gs.stage_buffer)
; map('n', '<leader>hu', gs.undo_stage_hunk)
; map('n', '<leader>hR', gs.reset_buffer)
; map('n', '<leader>hp', gs.preview_hunk)
; map('n', '<leader>hb', function() gs.blame_line{full=true} end)
; map('n', '<leader>tb', gs.toggle_current_line_blame)
; map('n', '<leader>hd', gs.diffthis)
; map('n', '<leader>hD', function() gs.diffthis('~') end)
; map('n', '<leader>td', gs.toggle_deleted)

; -- Text object
; map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')}))

(local signs
  { :add { :hl "GitGutterAdd" :text "+"
                 :change { :hl "GitGutterChange" :text "~"}
                 :delete { :hl "GitGutterDelete" :text "_"}
                 :topdelete { :hl "GitGutterDelete" :text "‾"}
                 :changedelete { :hl "GitGutterChange" :text "~"}}})

(λ configure [] (gitsigns.setup {: signs : on_attach})) 
{: configure}
