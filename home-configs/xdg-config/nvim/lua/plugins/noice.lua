-- [nfnl] Compiled from fnl/plugins/noice.fnl by https://github.com/Olical/nfnl, do not edit.
local noice = require("noice")
local function configure()
  return noice.setup({lsp = {override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true}}, presets = {bottom_search = true, command_palette = true, long_message_to_split = true, lsp_doc_border = true, inc_rename = false}, cmdline = {view = "cmdline"}})
end
return {configure = configure}
