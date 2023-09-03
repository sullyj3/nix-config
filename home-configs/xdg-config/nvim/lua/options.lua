if vim.g.neovide ~= nil then
  vim.o.guifont = 'DejaVuSansMono Nerd font:h6.7'
  vim.g.neovide_scroll_animation_length = 0.5
end

-- Case insensitive file tab completion in command line mode
vim.o.wildignorecase = true

vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = 'a'

--Wrapped lines start at same indentation
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (needs to come after colorscheme is installed)
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end
-- vim.g.onedark_terminal_italics = 2
-- vim.cmd [[colorscheme tender]]
-- vim.cmd [[colorscheme nord]]
vim.g.everforest_background = 'hard'
vim.cmd.colorscheme 'everforest'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.cursorline = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false
