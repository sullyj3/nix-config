; Case insensitive file tab completion in command line mode
(set vim.o.wildignorecase true)

(set vim.o.hlsearch true)
(set vim.wo.number true)
(set vim.o.mouse "a")

; Wrapped lines start at same indentation
(set vim.o.breakindent true)

; Save undo history
(set vim.opt.undofile true)

; Case insensitive searching UNLESS /C or capital in search
(set vim.o.ignorecase true)
(set vim.o.smartcase true)

; Decrease update time
(set vim.o.updatetime 250)
(set vim.wo.signcolumn "yes")

; Set colorscheme (needs to come after colorscheme is installed)
; (vim.cmd.colorscheme "kanagawa")

; Set completeopt to have a better completion experience
(set vim.o.completeopt "menu,noselect")

(set vim.o.cursorline true)

(vim.cmd
  (.. "augroup YankHighlight\n"
      "autocmd!\n"
      "autocmd TextYankPost * silent! lua vim.highlight.on_yank()\n"
      "augroup end\n"))
