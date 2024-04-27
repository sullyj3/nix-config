-- [nfnl] Compiled from fnl/options.fnl by https://github.com/Olical/nfnl, do not edit.
if (vim.g.neovide ~= nil) then
  vim.o.guifont = "DejaVuSansMono Nerd font:h6.7"
  vim.g.neovide_scroll_animation_length = 0.5
else
end
vim.o.wildignorecase = true
vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
if (vim.fn.has("termguicolors") == 1) then
  vim.o.termguicolors = true
else
end
vim.cmd.colorscheme("kanagawa")
vim.o.completeopt = "menuone,noselect"
vim.o.cursorline = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.cmd(("augroup YankHighlight\n" .. "autocmd!\n" .. "autocmd TextYankPost * silent! lua vim.highlight.on_yank()\n" .. "augroup end\n"))
vim.g.indent_blankline_char = "\226\148\138"
vim.g.indent_blankline_filetype_exclude = {"help", "packer"}
vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
return nil
