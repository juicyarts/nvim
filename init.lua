-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.loader.enable()

require('config.lazy')
require('config.misc')
require('config.ui')
require('config.keymap')
require('config.lsp')

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
