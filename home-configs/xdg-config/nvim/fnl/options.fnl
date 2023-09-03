(when (not= vim.g.neovide nil)
  (set vim.o.guifont "DejaVuSansMono Nerd font:h6.7")
  (set vim.g.neovide_scroll_animation_length 0.5))

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
(when (= (vim.fn.has "termguicolors") 1)
  (set vim.o.termguicolors true))

(set vim.g.everforest_background "hard")
(vim.cmd.colorscheme "everforest")

; Set completeopt to have a better completion experience
(set vim.o.completeopt "menuone,noselect")

(set vim.o.cursorline true)
(set vim.o.tabstop 2)
(set vim.o.shiftwidth 2)

(vim.cmd
  (.. "augroup YankHighlight\n"
      "autocmd!\n"
      "autocmd TextYankPost * silent! lua vim.highlight.on_yank()\n"
      "augroup end\n"))

(set vim.g.indent_blankline_char "┊")
(set vim.g.indent_blankline_filetype_exclude ["help" "packer"])
(set vim.g.indent_blankline_buftype_exclude ["terminal" "nofile"])
(set vim.g.indent_blankline_show_trailing_blankline_indent false)
