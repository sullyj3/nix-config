-- [nfnl] Compiled from fnl/plugins/nvim-lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local core = require("nfnl.core")
local _local_1_ = core
local concat = _local_1_["concat"]
local utils = require("utils")
local _local_2_ = utils
local buf_nmap = _local_2_["buf_nmap"]
local nvim_navic = require("nvim-navic")
local nvim_navbuddy = require("nvim-navbuddy")
local telescope_builtin = require("telescope.builtin")
local function on_attach(client, bufnr)
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  if client.server_capabilities.documentSymbolProvider then
    nvim_navic.attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    nvim_navbuddy.attach(client, bufnr)
    buf_nmap("<leader>n", vim.cmd.Navbuddy)
  else
  end
  buf_nmap("gD", vim.lsp.buf.declaration)
  buf_nmap("gd", vim.lsp.buf.definition)
  buf_nmap("K", vim.lsp.buf.hover)
  buf_nmap("gi", vim.lsp.buf.implementation)
  buf_nmap("<C-k>", vim.lsp.buf.signature_help)
  buf_nmap("<leader>wa", vim.lsp.buf.add_workspace_folder)
  buf_nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder)
  local function _4_()
    return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end
  buf_nmap("<leader>wl", _4_)
  buf_nmap("<leader>D", vim.lsp.buf.type_definition)
  buf_nmap("<leader>rn", vim.lsp.buf.rename)
  buf_nmap("gr", vim.lsp.buf.references)
  buf_nmap("<leader>ca", vim.lsp.buf.code_action)
  buf_nmap("<leader>e", vim.diagnostic.open_float)
  buf_nmap("[d", vim.diagnostic.goto_prev)
  buf_nmap("]d", vim.diagnostic.goto_next)
  buf_nmap("<leader>q", vim.diagnostic.setloclist)
  buf_nmap("<leader>d", telescope_builtin.lsp_document_symbols)
  local function _5_()
    return vim.lsp.buf.format({async = true})
  end
  vim.api.nvim_create_user_command("Format", _5_, {desc = "Format the file using LSP provided formatter"})
  if client.server_capabilities.codeLensProvider then
    buf_nmap("<leader>l", vim.lsp.codelens.run)
    vim.cmd("augroup LspCodelensAutoGroup")
    vim.cmd("au!")
    vim.cmd("au BufEnter <buffer> lua vim.lsp.codelens.refresh()")
    vim.cmd("au CursorHold <buffer> lua vim.lsp.codelens.refresh()")
    vim.cmd("au InsertLeave <buffer> lua vim.lsp.codelens.refresh()")
    return vim.cmd("augroup end")
  else
    return print("CodeLens not supported by language server")
  end
end
local function configure()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local capabilities = cmp_nvim_lsp.default_capabilities()
  lspconfig.hls.setup({capabilities = capabilities, on_attach = on_attach, settings = {haskell = {checkParents = "AlwaysCheck", formattingProvider = "fourmolu"}}})
  local other_servers = {"html", "cssls", "rust_analyzer", "jedi_language_server", "gdscript", "ocamllsp", "tsserver"}
  for _, lsp in ipairs(other_servers) do
    local config = lspconfig[lsp]
    config.setup({capabilities = capabilities, on_attach = on_attach})
  end
  do
    local runtime_path = concat(vim.split(package.path, ";"), {"lua/?.lua", "lua/?/init.lua"})
    lspconfig.lua_ls.setup({capabilities = capabilities, on_attach = on_attach, settings = {Lua = {diagnostics = {globals = {"vim"}}, runtime = {path = runtime_path, version = "LuaJIT"}, telemetry = {enable = false}, workspace = {library = vim.api.nvim_get_runtime_file("", true)}}}})
  end
  lspconfig.fennel_language_server.setup({capabilities = capabilities, on_attach = on_attach, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}})
  local lean = require("lean")
  return lean.setup({lsp = {on_attach = on_attach}, mappings = true})
end
return {configure = configure}
