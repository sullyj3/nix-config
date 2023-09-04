-- [nfnl] Compiled from fnl/plugins/nvim-cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local luasnip = require("luasnip")
local cmp = require("cmp")
local function configure()
  local function _1_(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    else
      return fallback()
    end
  end
  local function _3_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    elseif luasnip.jumpable(( - 1)) then
      return luasnip.jump(( - 1))
    else
      return fallback()
    end
  end
  local function _5_(args)
    return luasnip.lsp_expand(args.body)
  end
  return cmp.setup({mapping = {["<C-Space>"] = cmp.mapping.complete(), ["<C-d>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-e>"] = cmp.mapping.close(), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-p>"] = cmp.mapping.select_prev_item(), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}), ["<Tab>"] = _1_, ["<S-Tab>"] = _3_}, snippet = {expand = _5_}, sources = {{name = "nvim_lsp"}, {name = "luasnip"}}})
end
return {configure = configure}
