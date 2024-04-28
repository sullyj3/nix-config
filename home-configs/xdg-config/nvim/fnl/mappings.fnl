(local utils (require :utils))

; Remap space as leader key
; Needs to come before any <leader> mappings (eg in plugin configuations))
(utils.map "" "<Space>" "<Nop>")
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")

; Remap for dealing with word wrap
(utils.nmap "k" "v:count == 0 ? 'gk' : 'k'" {:expr true})
(utils.nmap "j" "v:count == 0 ? 'gj' : 'j'" {:expr true})

(utils.nmap "<leader><tab>" ":bnext<CR>")

; system paste
(utils.nmap "<leader>v" "\"+p")

