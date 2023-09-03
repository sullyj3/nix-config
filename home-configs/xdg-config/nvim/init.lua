-- TODO switch to fennel? see https://github.com/Olical/nfnl
-- TODO migrate to new style mappings (vim.keymap.set instead of vim.api.nvim_set_keymap)
--   - this allows providing lua functions as rhs instead of having write '<cmd>lua ...<CR>'
--   - probably best to setup a function which defaults to norermap and silent

-- Setting <leader>, which occurs in 'mappings' needs to come before any 
-- <leader> mappings in plugin configurations
require 'mappings'
require 'commands'
require 'plugins'
require 'options'
