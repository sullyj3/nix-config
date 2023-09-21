(local core (require :nfnl.core))
(local {: concat} core)
(local utils (require :utils))
(local {: buf_nmap} utils)
(local nvim-navic (require :nvim-navic))
(local nvim-navbuddy (require :nvim-navbuddy))
(local telescope-builtin (require :telescope.builtin))

(fn on-attach [client bufnr]
  (set vim.bo.omnifunc "v:lua.vim.lsp.omnifunc")
  (when client.server_capabilities.documentSymbolProvider
    (nvim-navic.attach client bufnr)
    (set vim.o.winbar "%{%v:lua.require'nvim-navic'.get_location()%}")
    (nvim-navbuddy.attach client bufnr)
    (buf_nmap :<leader>n vim.cmd.Navbuddy))

  (buf_nmap :gD vim.lsp.buf.declaration)
  (buf_nmap :gd vim.lsp.buf.definition)
  (buf_nmap :K vim.lsp.buf.hover)
  (buf_nmap :gi vim.lsp.buf.implementation)
  (buf_nmap :<C-k> vim.lsp.buf.signature_help)
  (buf_nmap :<leader>wa vim.lsp.buf.add_workspace_folder)
  (buf_nmap :<leader>wr vim.lsp.buf.remove_workspace_folder)
  (buf_nmap :<leader>wl
            #(-> (vim.lsp.buf.list_workspace_folders)
                 (vim.inspect)
                 (print)))
  (buf_nmap :<leader>D vim.lsp.buf.type_definition)
  (buf_nmap :<leader>rn vim.lsp.buf.rename)
  (buf_nmap :gr vim.lsp.buf.references)
  (buf_nmap :<leader>ca vim.lsp.buf.code_action)
  (buf_nmap :<leader>e vim.diagnostic.open_float)
  (buf_nmap "[d" vim.diagnostic.goto_prev)
  (buf_nmap "]d" vim.diagnostic.goto_next)
  (buf_nmap :<leader>q vim.diagnostic.setloclist)
  (buf_nmap :<leader>d telescope-builtin.lsp_document_symbols)
  (vim.api.nvim_create_user_command :Format 
                                    #(vim.lsp.buf.format {:async true})
                                    {:desc "Format the file using LSP provided formatter"})
  (if client.server_capabilities.codeLensProvider
      (do
        (buf_nmap :<leader>l vim.lsp.codelens.run)
        (vim.cmd "augroup LspCodelensAutoGroup")
        (vim.cmd :au!)
        (vim.cmd "au BufEnter <buffer> lua vim.lsp.codelens.refresh()")
        (vim.cmd "au CursorHold <buffer> lua vim.lsp.codelens.refresh()")
        (vim.cmd "au InsertLeave <buffer> lua vim.lsp.codelens.refresh()")
        (vim.cmd "augroup end"))
      (print "CodeLens not supported by language server")))

(λ configure []
  (let [lspconfig (require :lspconfig)
        cmp_nvim_lsp (require :cmp_nvim_lsp)
        capabilities (cmp_nvim_lsp.default_capabilities)]
    (lspconfig.hls.setup {: capabilities
                          :on_attach on-attach
                          :settings {:haskell {:checkParents :AlwaysCheck
                                               :formattingProvider :fourmolu}}})
    (local other-servers [:html
                          :cssls
                          :rust_analyzer
                          :jedi_language_server
                          :gdscript
                          :ocamllsp
                          :tsserver])
    (each [_ lsp (ipairs other-servers)]
      (let [config (. lspconfig lsp)]
        (config.setup {: capabilities :on_attach on-attach})))

    (let [ runtime-path 
           (concat (vim.split package.path ";") [:lua/?.lua :lua/?/init.lua])]
      (lspconfig.lua_ls.setup 
        {: capabilities
         :on_attach on-attach
         :settings {:Lua {:diagnostics {:globals [:vim]}
                          :runtime {:path runtime-path
                                    :version :LuaJIT}
                          :telemetry {:enable false}
                          :workspace {:library (vim.api.nvim_get_runtime_file ""
                                                                              true)}}}}))
    (lspconfig.fennel_language_server.setup 
      {: capabilities
       :on_attach on-attach
       :root_dir (lspconfig.util.root_pattern :fnl)
       :settings {:fennel {:diagnostics {:globals [:vim]}
                           :workspace {:library (vim.api.nvim_list_runtime_paths)}}}})))

{: configure}
